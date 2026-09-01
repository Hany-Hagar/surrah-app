import 'transactions_states.dart';
import 'package:flutter/material.dart';
import '../../data/model/balance_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repo/transactions_repo.dart';
import '../../data/model/transaction_model.dart';
import '../../../../core/enums/category_type.dart';
import '../../data/model/transactions_data_model.dart';
import '../../../../core/widgets/categories_picker.dart';
import '../../../../core/extensions/transaction_extension.dart';
import '../../../../core/extensions/transactions_data_model_extensions.dart';
import '../../../categories/data/database/default_categories.dart';

class TransactionsCubit extends Cubit<TransactionsStates> {
  final TransactionsRepo transactionsRepo;

  TransactionsCubit({required this.transactionsRepo})
    : super(TransactionsInitial());
  static TransactionsCubit get(BuildContext context) =>
      BlocProvider.of(context);

  List<TransactionModel> transactions = [];
  BalanceModel currentBalance = BalanceModel.empty();
  TransactionsDataModel transactionsData = TransactionsDataModel.empty();

  // Get Transactions Data
  Future<void> getTransactionsData() async {
    emit(GetTransactionsLoading());
    var result = await transactionsRepo.getTransactionsData();
    result.fold(
      (failure) => emit(GetTransactionsFailure(message: failure.message)),
      (success) {
        transactionsData = success;
        transactions = success.transactions;
        currentBalance = success.currentBalance;
        emit(GetTransactionsSuccess());
      },
    );
  }

  // Search Transactions
  bool isSearching = false;
  bool isFiltering = false;
  List<TransactionModel> searchResults = [];
  var searchController = TextEditingController();
  CategoriesType selectedType = CategoriesType.all;
  List<TransactionModel> filteredTransactions = [];

  void searchTransactions({required String? query}) {
    if (query == null || query.isEmpty) {
      isSearching = false;
      searchResults.clear();
      searchController.clear();
      emit(SearchTransactionsState());
      return;
    }
    isSearching = true;
    if (isFiltering) {
      searchResults = filteredTransactions.search(query: query);
    } else {
      searchResults = transactions.search(query: query);
    }
    emit(SearchTransactionsState());
  }

  void changeSelectedType(CategoriesType type) {
    selectedType = type;
    emit(SearchTransactionsState());
  }

  void filterCategories() {
    isFiltering = true;
    filteredTransactions = transactions.filter(type: selectedType);
    emit(SearchTransactionsState());
  }

  void clearFilter() {
    isFiltering = false;
    searchResults.clear();
    selectedType = CategoriesType.all;
    emit(SearchTransactionsState());
  }

  // Add Transaction
  DateTime selectedDate = DateTime.now();
  var categories = DefaultCategories.all;
  var notesController = TextEditingController();
  var amountController = TextEditingController();
  var autoValidateMode = AutovalidateMode.disabled;
  var selectedCategory = DefaultCategories.all.first;
  var transactionToEdit = TransactionModel.empty();

  void initalData({
    required bool isIncome,
    required bool isEdit,
    TransactionModel? transaction,
  }) {
    if (isEdit && transaction != null) {
      autoValidateMode = AutovalidateMode.onUserInteraction;
      transactionToEdit = transaction;
      notesController.text = transaction.notes;
      amountController.text = transaction.amount.toString();
      selectedDate = transaction.createdAt;
      selectedCategory = DefaultCategories.all.firstWhere(
        (cat) => cat.id == transaction.categoryId,
      );
      emit(AddTransactionInitial());
      return;
    }
    autoValidateMode = AutovalidateMode.disabled;
    if (isIncome) {
      categories = DefaultCategories.income;
      selectedCategory = DefaultCategories.income.first;
    } else {
      categories = DefaultCategories.expense;
      selectedCategory = DefaultCategories.expense.first;
    }
    emit(AddTransactionInitial());
  }

  void updateSelectedCategory({required BuildContext context}) {
    CategoriesPicker.show(
      context: context,
      categoriesType: selectedCategory.isIncome
          ? CategoriesType.income
          : CategoriesType.expense,
      selectedCategory: selectedCategory,
    ).then((value) {
      if (value != null) {
        selectedCategory = value;
        emit(UpdateSelectedCategory());
      }
    });
  }

  void updateSelectedDate({required DateTime date}) {
    selectedDate = date;
    emit(UpdateSelectedDate());
  }

  Future<void> addTransaction({
    required bool isIncome,
    required GlobalKey<FormState> formKey,
  }) async {
    if (!formKey.currentState!.validate()) {
      autoValidateMode = AutovalidateMode.onUserInteraction;
      emit(AutoValidateModeChanged());
      return;
    }
    emit(AddTransactionLoading());
    var transaction = TransactionModel.newTransaction(
      isIncome: isIncome,
      createdAt: selectedDate,
      notes: notesController.text,
      categoryId: selectedCategory.id,
      amount: double.parse(amountController.text),
    );
    var result = await transactionsRepo.updateTransactionsData(
      data: transactionsData.addTransaction(transaction: transaction),
    );
    result.fold(
      (failure) => emit(AddTransactionFailure(message: failure.message)),
      (success) {
        transactionsData = success;
        transactions = success.transactions;
        currentBalance = success.currentBalance;
        emit(AddTransactionSuccess());
        clearFields();
      },
    );
  }

  Future<void> updateTransaction({
    required bool isIncome,
    required GlobalKey<FormState> formKey,
  }) async {
    if (!formKey.currentState!.validate()) {
      autoValidateMode = AutovalidateMode.onUserInteraction;
      emit(AutoValidateModeChanged());
      return;
    }
    emit(UpdateTransactionLoading());
    var updateTransaction = transactionToEdit.copyWith(
      createdAt: selectedDate,
      notes: notesController.text,
      categoryId: selectedCategory.id,
      amount: double.parse(amountController.text),
    );
    var result = await transactionsRepo.updateTransactionsData(
      data: transactionsData.editTransaction(
        oldTransaction: transactionToEdit,
        newTransaction: updateTransaction,
      ),
    );
    result.fold(
      (failure) => emit(UpdateTransactionFailure(message: failure.message)),
      (success) {
        transactionsData = success;
        transactions = success.transactions;
        currentBalance = success.currentBalance;
        emit(UpdateTransactionSuccess());
        clearFields();
      },
    );
  }

  void clearFields() {
    selectedDate = DateTime.now();
    notesController.clear();
    amountController.clear();
    selectedCategory = DefaultCategories.all.first;
  }
}

import 'transactions_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repo/transactions_repo.dart';
import '../../data/model/transaction_model.dart';
import '../../../../core/enums/category_type.dart';
import '../../../../core/widgets/categories_picker.dart';
import '../../../../core/extensions/transaction_extension.dart';
import '../../../categories/data/database/default_categories.dart';

class TransactionsCubit extends Cubit<TransactionsStates> {
  final TransactionsRepo transactionsRepo;

  TransactionsCubit({required this.transactionsRepo})
    : super(TransactionsInitial());
  static TransactionsCubit get(BuildContext context) =>
      BlocProvider.of(context);

  List<TransactionModel> transactions = [];

  // Get Transactions
  Future<void> getTransactions() async {
    emit(GetTransactionsLoading());
    var result = await transactionsRepo.getTransactions();
    result.fold(
      (failure) => emit(GetTransactionsFailure(message: failure.message)),
      (transactionsList) {
        transactions.addAll(transactionsList);
        emit(GetTransactionsSuccess());
      },
    );
  }

  // Search Transactions
  bool isSearching = false;
  List<TransactionModel> searchResults = [];
  var searchController = TextEditingController();

  void searchTransactions({
    required String? query,
    required BuildContext context,
  }) {
    if (query == null || query.isEmpty) {
      isSearching = false;
      searchResults.clear();
      searchController.clear();
      emit(SearchTransactionsState());
      return;
    }
    isSearching = true;
    searchResults = transactions.search(context: context, query: query);
    emit(SearchTransactionsState());
  }

  // Add Transaction
  DateTime selectedDate = DateTime.now();
  var categories = DefaultCategories.all;
  var notesController = TextEditingController();
  var amountController = TextEditingController();
  var autoValidateMode = AutovalidateMode.disabled;
  var selectedCategory = DefaultCategories.all.first;

  void initalData({required bool isIncome}) {
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
    var result = await transactionsRepo.addTransaction(transaction);
    result.fold(
      (failure) => emit(AddTransactionFailure(message: failure.message)),
      (success) {
        // Add in first
        transactions.insert(0, transaction);
        emit(AddTransactionSuccess());
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

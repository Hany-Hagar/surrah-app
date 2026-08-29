import 'transactions_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repo/transactions_repo.dart';
import '../../data/model/transaction_model.dart';
import '../../../../core/extensions/transaction_extension.dart';

class TransactionsCubit extends Cubit<TransactionsStates> {
  final TransactionsRepo transactionsRepo;

  TransactionsCubit({required this.transactionsRepo})
    : super(TransactionsInitial());
  static TransactionsCubit get(BuildContext context) =>
      BlocProvider.of(context);

  List<TransactionModel> transactions = defaultTransactions;

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

  void searchTransactions({required String? query, required BuildContext context}) {
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
}

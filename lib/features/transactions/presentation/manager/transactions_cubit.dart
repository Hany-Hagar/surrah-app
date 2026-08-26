import 'transactions_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repo/transactions_repo.dart';
import '../../data/model/transaction_model.dart';

class TransactionsCubit extends Cubit<TransactionsStates> {
  final TransactionsRepo transactionsRepo;

  TransactionsCubit({required this.transactionsRepo})
    : super(TransactionsInitial());

  List<TransactionModel> transactions = [];

  // Get Transactions
  Future<void> getTransactions() async {
    emit(GetTransactionsLoading());
    var result = await transactionsRepo.getTransactions();
    result.fold(
      (failure) => emit(GetTransactionsFailure(message: failure.message)),
      (transactionsList) {
        transactions = transactionsList;
        emit(GetTransactionsSuccess());
      },
    );
  }

  // Add Transaction
  Future<void> addTransaction(TransactionModel transaction) async {
    emit(AddTransactionLoading());
    var result = await transactionsRepo.addTransaction(transaction);
    result.fold(
      (failure) => emit(AddTransactionFailure(message: failure.message)),
      (_) {
        emit(AddTransactionSuccess());
        getTransactions();
      },
    );
  }

  // Update Transaction
  Future<void> updateTransaction(TransactionModel transaction) async {
    emit(UpdateTransactionLoading());
    var result = await transactionsRepo.updateTransaction(transaction);
    result.fold(
      (failure) => emit(UpdateTransactionFailure(message: failure.message)),
      (_) {
        emit(UpdateTransactionSuccess());
        getTransactions();
      },
    );
  }

  // Delete Transaction
  Future<void> deleteTransaction(String transactionId) async {
    emit(DeleteTransactionLoading());
    var result = await transactionsRepo.deleteTransaction(transactionId);
    result.fold(
      (failure) => emit(DeleteTransactionFailure(message: failure.message)),
      (_) {
        emit(DeleteTransactionSuccess());
        getTransactions();
      },
    );
  }
}

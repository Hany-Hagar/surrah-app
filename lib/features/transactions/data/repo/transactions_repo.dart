import 'package:dartz/dartz.dart';
import '../model/transaction_model.dart';
import '../../../../core/errors/failure.dart';
import '../model/transactions_data_model.dart';

abstract class TransactionsRepo {
  // Get Transactions Data
  Future<Either<Failure, TransactionsDataModel>> getTransactionsData();

  // Add Transaction
  Future<Either<Failure, TransactionsDataModel>> addTransaction({
    required TransactionsDataModel data,
    required TransactionModel transaction,
  });

  // Update Transaction
  Future<Either<Failure, TransactionsDataModel>> updateTransaction({
    required TransactionsDataModel data,
    required TransactionModel transaction,
    required TransactionModel updatedTransaction,
  });

  // Delete Transaction
  Future<Either<Failure, TransactionsDataModel>> deleteTransaction({
    required TransactionsDataModel data,
    required TransactionModel transaction,
  });

  // Delete Transactions Data
  Future<Either<Failure, void>> deleteTransactionsData();
}

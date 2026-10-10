import 'package:surrah/core/extensions/transactions_data_model_extensions.dart';

import 'transactions_repo.dart';
import 'package:dartz/dartz.dart';
import '../model/transaction_model.dart';
import '../database/transactions_data.dart';
import '../../../../core/errors/failure.dart';
import '../model/transactions_data_model.dart';
import '../../../../core/errors/hive_failure.dart';

class TransactionsRepoImpl extends TransactionsRepo {
  final TransactionsData transactionsData;
  TransactionsRepoImpl({required this.transactionsData});

  // Get Transactions Data
  @override
  Future<Either<Failure, TransactionsDataModel>> getTransactionsData() async {
    try {
      final transactionsDataModel = transactionsData.getTransactionsData();
      return Right(transactionsDataModel);
    } catch (e) {
      return Left(HiveFailure.fromError(e));
    }
  }

  // Add Transaction
  @override
  Future<Either<Failure, TransactionsDataModel>> addTransaction({
    required TransactionsDataModel data,
    required TransactionModel transaction,
  }) async {
    try {
      var updatedData = data.addTransaction(transaction: transaction);
      await transactionsData.updateTransactionsData(updatedData);
      return Right(updatedData);
    } catch (e) {
      return Left(HiveFailure.fromError(e));
    }
  }

  // Update Transaction
  @override
  Future<Either<Failure, TransactionsDataModel>> updateTransaction({
    required TransactionsDataModel data,
    required TransactionModel transaction,
    required TransactionModel updatedTransaction,
  }) async {
    try {
      var updatedData = data.editTransaction(
        oldTransaction: transaction,
        newTransaction: updatedTransaction,
      );
      await transactionsData.updateTransactionsData(updatedData);
      return Right(updatedData);
    } catch (e) {
      return Left(HiveFailure.fromError(e));
    }
  }

  // Delete Transaction
  @override
  Future<Either<Failure, TransactionsDataModel>> deleteTransaction({
    required TransactionsDataModel data,
    required TransactionModel transaction,
  }) async {
    try {
      var updatedData = data.removeTransaction(transaction: transaction);
      await transactionsData.updateTransactionsData(updatedData);
      return Right(updatedData);
    } catch (e) {
      return Left(HiveFailure.fromError(e));
    }
  }

  // Delete Transactions Data
  @override
  Future<Either<Failure, void>> deleteTransactionsData() async {
    try {
      await transactionsData.deleteTransactionsData();
      return const Right(null);
    } catch (e) {
      return Left(HiveFailure.fromError(e));
    }
  }
}

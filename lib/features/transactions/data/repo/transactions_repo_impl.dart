import 'transactions_repo.dart';
import 'package:dartz/dartz.dart';
import '../model/transaction_model.dart';
import '../database/transactions_data.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/hive_failure.dart';
import '../../../../core/extensions/transaction_extension.dart';

class TransactionsRepoImpl extends TransactionsRepo {
  final TransactionsData transactionsData;
  TransactionsRepoImpl({required this.transactionsData});

  @override
  Future<Either<Failure, List<TransactionModel>>> getTransactions() async {
    try {
      final transactions = transactionsData.getAllTransactions();
      return Right(transactions.sortByDate());
    } catch (e) {
      return Left(HiveFailure.fromError(e));
    }
  }

  @override
  Future<Either<Failure, TransactionModel>> addTransaction(
    TransactionModel transaction,
  ) async {
    try {
      await transactionsData.addTransaction(transaction);
      return Right(transaction);
    } catch (e) {
      return Left(HiveFailure.fromError(e));
    }
  }

  @override
  Future<Either<Failure, TransactionModel>> updateTransaction(
    TransactionModel transaction,
  ) async {
    try {
      await transactionsData.updateTransaction(transaction);
      return Right(transaction);
    } catch (e) {
      return Left(HiveFailure.fromError(e));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTransaction(String transactionId) async {
    try {
      await transactionsData.deleteTransaction(transactionId);
      return const Right(null);
    } catch (e) {
      return Left(HiveFailure.fromError(e));
    }
  }
}

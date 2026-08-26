import 'package:dartz/dartz.dart';
import '../model/transaction_model.dart';
import '../../../../core/errors/failure.dart';

abstract class TransactionsRepo {
  Future<Either<Failure, List<TransactionModel>>> getTransactions();
  Future<Either<Failure, TransactionModel>> addTransaction(
    TransactionModel transaction,
  );
  Future<Either<Failure, TransactionModel>> updateTransaction(
    TransactionModel transaction,
  );
  Future<Either<Failure, void>> deleteTransaction(String transactionId);
}

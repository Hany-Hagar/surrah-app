import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../model/transactions_data_model.dart';

abstract class TransactionsRepo {
  Future<Either<Failure, TransactionsDataModel>> getTransactionsData();

  Future<Either<Failure, TransactionsDataModel>> updateTransactionsData({
    required TransactionsDataModel data,
  });

  Future<Either<Failure, void>> deleteTransactionsData();
}

import 'transactions_repo.dart';
import 'package:dartz/dartz.dart';
import '../database/transactions_data.dart';
import '../../../../core/errors/failure.dart';
import '../model/transactions_data_model.dart';
import '../../../../core/errors/hive_failure.dart';

class TransactionsRepoImpl extends TransactionsRepo {
  final TransactionsData transactionsData;
  TransactionsRepoImpl({required this.transactionsData});

  @override
  Future<Either<Failure, TransactionsDataModel>> getTransactionsData() async {
    try {
      final transactionsDataModel = transactionsData.getTransactionsData();
      return Right(transactionsDataModel);
    } catch (e) {
      return Left(HiveFailure.fromError(e));
    }
  }

  @override
  Future<Either<Failure, TransactionsDataModel>> updateTransactionsData({
    required TransactionsDataModel data,
  }) async {
    try {
      await transactionsData.updateTransactionsData(data);
      return Right(data);
    } catch (e) {
      return Left(HiveFailure.fromError(e));
    }
  }

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

import 'package:dartz/dartz.dart';
import 'package:surrah/core/errors/failure.dart';
import 'package:surrah/features/report/data/database/report_data.dart';
import 'package:surrah/features/report/data/repo/report_repo.dart';
import 'package:surrah/features/transactions/data/model/transactions_data_model.dart';

import '../../../../core/errors/hive_failure.dart';
import '../../../categories/data/models/category_model.dart';

class ReportRepoImpl implements ReportRepo {
  ReportRepoImpl({required this.reportData});

  final ReportData reportData;

  @override
  Future<Either<Failure, TransactionsDataModel>> getTransactionsData() async {
    try {
      final data = reportData.getTransactionsData();
      return Right(data);
    } catch (e) {
      return Left(HiveFailure.fromError(e));
    }
  }
  @override
  Future<Either<Failure, List<CategoryModel>>> getCategoriesData() async {
    try {
      final data = reportData.getCategoriesData();
      return Right(data);
    } catch (e) {
      return Left(HiveFailure.fromError(e));
    }
  }
}
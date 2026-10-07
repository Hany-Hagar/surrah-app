import 'report_repo.dart';
import 'package:dartz/dartz.dart';
import '../model/report_model.dart';
import '../database/report_data.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/hive_failure.dart';
import '../../../../core/enums/date_filter_type.dart';
import '../../../../core/extensions/transaction_extension.dart';

class ReportRepoImpl implements ReportRepo {
  final ReportData reportData;
  ReportRepoImpl({required this.reportData});

  @override
  Future<Either<Failure, ReportModel>> fetchData({
    required DateFilterType date,
  }) async {
    try {
      final data = reportData.fetchData().transactions.sortByAmount();
      var report = data.getReportData(dateFilterType: date);
      return Right(report);
    } catch (e) {
      return Left(HiveFailure.fromError(e));
    }
  }
}

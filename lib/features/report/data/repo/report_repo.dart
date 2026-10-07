import 'package:dartz/dartz.dart';
import '../model/report_model.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/enums/date_filter_type.dart';

abstract class ReportRepo {
  Future<Either<Failure, ReportModel>> fetchData({
    required DateFilterType date,
  });
}

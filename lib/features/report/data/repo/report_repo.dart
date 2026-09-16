import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../transactions/data/model/transactions_data_model.dart';

abstract class ReportRepo {
  Future<Either<Failure, TransactionsDataModel>> getTransactionsData();
}
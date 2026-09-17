import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../categories/data/models/category_model.dart';
import '../../../transactions/data/model/transactions_data_model.dart';

abstract class ReportRepo {
  Future<Either<Failure, TransactionsDataModel>> getTransactionsData();
  Future<Either<Failure, List<CategoryModel>>> getCategoriesData();

}
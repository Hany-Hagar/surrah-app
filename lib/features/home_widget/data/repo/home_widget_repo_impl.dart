import 'package:surrah/core/errors/hive_failure.dart';

import '../model/home_widget_model.dart';
import 'home_widget_repo.dart';
import 'package:dartz/dartz.dart';
import '../database/home_widget_data.dart';
import '../../../../core/errors/failure.dart';

class HomeWidgetRepoImpl extends HomeWidgetRepo {
  final HomeWidgetData data;
  HomeWidgetRepoImpl({required this.data});

  @override
  Either<Failure, HomeWidgetModel> getHomeWidgetData() {
    try {
      var currentBalance = data.getCurrentBalance();
      var homeWidgetData = data.getHomeWidgetData();
      return Right(homeWidgetData.copyWith(balance: currentBalance));
    } catch (e) {
      return Left(HiveFailure.fromError(e));
    }
  }

  @override
  Future<Either<Failure, void>> saveHomeWidgetData(
    HomeWidgetModel homeWidgetData,
  ) async {
    try {
      await data.saveHomeWidgetData(homeWidgetData);
      return const Right(null);
    } catch (e) {
      return Left(HiveFailure.fromError(e));
    }
  }
}

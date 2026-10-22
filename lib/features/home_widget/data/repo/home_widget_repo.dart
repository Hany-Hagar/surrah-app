import 'package:dartz/dartz.dart';
import '../model/home_widget_model.dart';
import '../../../../core/errors/failure.dart';

abstract class HomeWidgetRepo {
  Either<Failure, HomeWidgetModel> getHomeWidgetData();
  Future<Either<Failure, void>> saveHomeWidgetData(
    HomeWidgetModel homeWidgetData,
  );
}

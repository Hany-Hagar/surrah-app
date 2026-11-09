import 'package:dartz/dartz.dart';
import '../model/home_widget_model.dart';
import '../../../../core/errors/failure.dart';

abstract class HomeWidgetRepo {

  // Get Data
  HomeWidgetModel getHomeWidgetData();

  // Save Data
  Future<Either<Failure, void>> saveHomeWidgetData(
    HomeWidgetModel homeWidgetData,
  );

  // Update Widget
  Future<Either<Failure, void>> updateHomeWidget(HomeWidgetModel homeWidgetData);

}

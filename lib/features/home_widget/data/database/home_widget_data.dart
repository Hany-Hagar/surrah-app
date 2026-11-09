import '../model/home_widget_model.dart';
import '../../../../const/hive_data.dart';
import '../../../../core/services/hive_service.dart';
import '../../../../core/services/home_widget_service.dart';
import '../../../transactions/data/model/transactions_data_model.dart';

class HomeWidgetData {
  final HiveService hiveService;
  final HomeWidgetService homeWidgetService;
  HomeWidgetData({required this.homeWidgetService, required this.hiveService});

  // Get Balance
  double getCurrentBalance() {
    final box = hiveService.box<TransactionsDataModel>(
      HiveData.transactionsDataBox,
    );
    if (box.values.isEmpty) return 0.0;
    return box.values.first.currentBalance.balance;
  }

  // Get Home Widget Data
  HomeWidgetModel getHomeWidgetData() {
    final box = hiveService.box<HomeWidgetModel>(HiveData.homeWidgetDataBox);
    return box.values.first;
  }

  // Save Home Widget Data
  Future<void> saveHomeWidgetData(HomeWidgetModel homeWidgetModel) async {
    await hiveService.put<HomeWidgetModel>(
      boxName: HiveData.homeWidgetDataBox,
      key: HiveData.homeWidgetDataKey,
      value: homeWidgetModel,
    );
  }

  // Update Home Widget
  Future<void> updateHomeWidget(HomeWidgetModel homeWidgetModel) async {
    return await HomeWidgetService.updateSettings(homeWidgetModel);
  }
}

import '../model/home_widget_model.dart';
import '../../../../const/hive_data.dart';
import '../../../../core/services/hive_service.dart';
import '../../../transactions/data/model/transactions_data_model.dart';

class HomeWidgetData {
  final HiveService hiveService;
  HomeWidgetData({required this.hiveService});

  // Get Balance
  double getCurrentBalance() {
    final box = hiveService.box<TransactionsDataModel>(
      HiveData.transactionsDataBox,
    );
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
}

import '../../../../const/hive_data.dart';
import '../model/transactions_data_model.dart';
import '../../../../core/services/hive_service.dart';

class TransactionsData {
  final HiveService hiveService;
  TransactionsData({required this.hiveService});

  // Get Transactions Data
  TransactionsDataModel getTransactionsData() {
    final box = hiveService.box<TransactionsDataModel>(
      HiveData.transactionsDataBox,
    );
    return box.values.first;
  }

  // Update Transactions Data
  Future<void> updateTransactionsData(TransactionsDataModel data) async {
    await hiveService.put<TransactionsDataModel>(
      boxName: HiveData.transactionsDataBox,
      key: HiveData.transactionsDataKey,
      value: data,
    );
  }

  // Delete Transactions Data
  Future<void> deleteTransactionsData() async {
    final box = hiveService.box<TransactionsDataModel>(
      HiveData.transactionsDataBox,
    );
    await box.clear();
  }
}

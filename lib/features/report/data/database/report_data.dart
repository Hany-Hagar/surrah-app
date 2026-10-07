import '../../../../const/hive_data.dart';
import '../../../../core/services/hive_service.dart';
import '../../../transactions/data/model/transactions_data_model.dart';

class ReportData {
  final HiveService hiveService;
  ReportData({required this.hiveService});

  TransactionsDataModel fetchData() {
    final box = hiveService.box<TransactionsDataModel>(
      HiveData.transactionsDataBox,
    );
    return box.values.first;
  }
}

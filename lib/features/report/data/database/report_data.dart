import '../../../../const/hive_data.dart';
import '../../../../core/services/hive_service.dart';
import '../../../transactions/data/model/transactions_data_model.dart';

class ReportData {
  ReportData({required this.hiveService});

  final HiveService hiveService ;

  TransactionsDataModel getTransactionsData() {
    final box = hiveService.box<TransactionsDataModel>(
      HiveData.transactionsDataBox,
    );
    return box.values.first;
  }

}
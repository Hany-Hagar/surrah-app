import 'package:pdf/widgets.dart' as pw;

import '../../../../const/hive_data.dart';
import '../../../../core/services/pdf_service.dart';
import '../../../../core/services/hive_service.dart';
import '../../../transactions/data/model/transactions_data_model.dart';

class ReportData {
  final PdfService pdfService;
  final HiveService hiveService;
  ReportData({required this.pdfService,required this.hiveService});

  TransactionsDataModel fetchData() {
    final box = hiveService.box<TransactionsDataModel>(
      HiveData.transactionsDataBox,
    );
    return box.values.first;
  }

  Future<void> downloadReport({required pw.Document document}) {
    return PdfService.download(document);
  }

  Future<void> shareReport({required pw.Document document}) {
    return PdfService.share(document);
  }
}

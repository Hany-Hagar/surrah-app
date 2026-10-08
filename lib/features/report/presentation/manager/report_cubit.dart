import 'report_state.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../data/repo/report_repo.dart';
import '../../data/model/report_model.dart';
import '../pages/views/report_pdf.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/enums/date_filter_type.dart';
import '../../../../core/extensions/number_formatting_extension.dart';

class ReportCubit extends Cubit<ReportStates> {
  final ReportRepo reportRepo;
  ReportCubit({required this.reportRepo}) : super(ReportInitial());
  static ReportCubit get(BuildContext context) => BlocProvider.of(context);

  // Data
  ReportModel data = ReportModel.empty();
  DateFilterType dateFilter = DateFilterType.day;

  // Functions
  void fetchData({DateFilterType date = DateFilterType.day}) async {
    dateFilter = date;
    emit(FetchReportLoading());
    final reportResult = await reportRepo.fetchData(date: date);
    reportResult.fold(
      (failure) => emit(FetchReportFailure(errorMessage: failure.message)),
      (reportData) {
        data = reportData;
        emit(FetchReportSuccess());
      },
    );
  }

  Future<pw.Document> _document({required BuildContext context}) async {
    var pages = await ReportPdfPages.create(
      report: data,
      formatMoney: (value) => value.moneyFormat(context: context),
    );
    return pages.pdf;
  }

  void downloadReport({required BuildContext context}) async {
    emit(DownloadReportLoading());
    final result = await reportRepo.downloadReport(
      document: await _document(context: context),
    );
    result.fold(
      (failure) => emit(DownloadReportFailure(errorMessage: failure.message)),
      (_) => emit(DownloadReportSuccess()),
    );
  }

  void shareReport({required BuildContext context}) async {
    emit(ShareReportLoading());
    final result = await reportRepo.shareReport(
      document: await _document(context: context),
    );
    result.fold(
      (failure) => emit(ShareReportFailure(errorMessage: failure.message)),
      (_) => emit(ShareReportSuccess()),
    );
  }
}

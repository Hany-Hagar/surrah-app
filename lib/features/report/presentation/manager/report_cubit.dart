import 'report_state.dart';
import 'package:flutter/material.dart';
import '../../data/repo/report_repo.dart';
import '../../data/model/report_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/enums/date_filter_type.dart';

class ReportCubit extends Cubit<ReportStates> {
  final ReportRepo reportRepo;
  ReportCubit({required this.reportRepo}) : super(ReportInitial());
  static ReportCubit get(BuildContext context) => BlocProvider.of(context);

  // Data
  ReportModel data = ReportModel.empty();
  DateFilterType dateFilter = DateFilterType.day;

  // Functions
  void fetchData({DateFilterType date = DateFilterType.day}) async {
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

  void changeDateFilter({required DateFilterType filter}) {
    dateFilter = filter;
    fetchData(date: filter);
  }
}

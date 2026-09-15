import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surrah/features/report/presentation/manager/report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit() : super(ReportInitial());

// ignore: non_constant_identifier_names
 void selectMonth(DateTime month) {
    emit(ReportMonthSelected(selectedMonth: month));
    
}


}

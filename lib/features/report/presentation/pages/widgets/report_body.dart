import 'analysis_card.dart';
import 'package:flutter/material.dart';
import '../../manager/report_cubit.dart';
import '../../manager/report_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportBody extends StatelessWidget {
  const ReportBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportCubit, ReportStates>(
      builder: (context, state) {
        var cubit = ReportCubit.get(context);
        return Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            spacing: 10.h,
            children: [
              AnalysisCard(
                title: 'Spending Analysis',
                total: cubit.data.totalExpense,
                isLoading: state is FetchReportLoading,
                transactions: cubit.data.groupedExpenses,
              ),
              AnalysisCard(
                title: 'Income Analysis',
                total: cubit.data.totalIncome,
                isLoading: state is FetchReportLoading,
                transactions: cubit.data.groupedIncomes,
              ),
              
            ],
          ),
        );
      },
    );
  }
}


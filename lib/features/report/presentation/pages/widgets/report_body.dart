import 'report_card.dart';
import 'analysis_card.dart';
import 'report_balance_card.dart';
import 'package:flutter/material.dart';
import '../../manager/report_cubit.dart';
import '../../manager/report_state.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/custom_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/transaction_extension.dart';
import '../../../../transactions/data/model/transaction_model.dart';
import '../../../../transactions/presentation/pages/widgets/transactions.dart';

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
              ReportBalanceCard(
                isLoading: state is FetchReportLoading,
                data: cubit.data,
              ),
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
              _Transactions(
                isLoading: state is FetchReportLoading,
                transactions: cubit.data.transactions,
              ),
              const _Share(),
            ],
          ),
        );
      },
    );
  }
}

class _Transactions extends StatelessWidget {
  final bool isLoading;
  final List<TransactionModel> transactions;
  const _Transactions({required this.isLoading, required this.transactions});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ReportCard(
      spacing: 4,
      isLoading: isLoading,
      title: 'Largest Transactions',
      subtitle: 'See all',
      subtitleColor: theme.primaryColor,
      onSubtitleTap: () {},
      body: Transactions(
        itemSperator: 0,
        isLoading: isLoading,
        categoryIconSize: 42,
        padding: EdgeInsets.zero,
        isCircleCategoryIcon: false,
        transactions: transactions.getLastTransactions(),
        scrollPhysics: const NeverScrollableScrollPhysics(),
        itemPadding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 4.h),
      ),
    );
  }
}

class _Share extends StatelessWidget {
  const _Share();

  @override
  Widget build(BuildContext context) {
    return ReportCard(
      spacing: 0,
      isLoading: false,
      title: 'Share Report',
      subtitle: "",
      body: Column(
        spacing: 10.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            size: 14.sp,
            text: "Share your report with your friends and family",
          ),
          _ShareButtons(),
        ],
      ),
    );
  }
}

class _ShareButtons extends StatelessWidget {
  const _ShareButtons();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportCubit, ReportStates>(
      builder: (context, state) {
        var cubit = ReportCubit.get(context);
        return Row(
          spacing: 10.w,
          children: [
            CustomButton(
              width: 60.w,
              height: 50.h,
              itemSize: 17,
              icon: Icons.share,
              enableBorderColor: true,
              isLoading: state is ShareReportLoading,
              onPressed: ()=> cubit.shareReport(context: context),
            ),
            Expanded(
              child: CustomButton(
                height: 50.h,
                itemSize: 19,
                text: "Download",
                icon: IconBroken.Download,
                isLoading: state is DownloadReportLoading,
                onPressed: ()=> cubit.downloadReport(context: context),
              ),
            ),
          ],
        );
      },
    );
  }
}

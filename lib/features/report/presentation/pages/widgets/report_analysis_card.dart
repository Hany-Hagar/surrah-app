import 'report_analysis_chart.dart';
import 'package:flutter/material.dart';
import '../../../models/report_model.dart';
import '../../../../../const/app_data.dart';
import '../../../../../core/widgets/custom_grid.dart';
import '../../../../../core/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/category_extension.dart';
import '../../../../transactions/data/model/transaction_model.dart';

class ReportAnalysisCard extends StatelessWidget {
  final ReportModel reportModel;
  const ReportAnalysisCard({super.key, required this.reportModel});

  @override
  Widget build(BuildContext context) {
    var length = reportModel.transactions.length;
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        boxShadow: defaultBoxShadow,
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: length > 6 && length <= 10
          ? _WrapTransactions(
              totalValue: reportModel.total,
              transactions: reportModel.transactions,
            )
          : _GridTransactions(
              totalValue: reportModel.total,
              transactions: reportModel.transactions,
            ),
  
    );
  }
}

class _WrapTransactions extends StatelessWidget {
  final double totalValue;
  final List<TransactionModel> transactions;
  const _WrapTransactions({
    required this.totalValue,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final chartWidth = constraints.maxWidth / 2;
        return Row(
          spacing: 10.w,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: chartWidth,
              child: ReportAnalysisChart(
                totalValue: totalValue,
                transactions: transactions,
                radius: chartWidth / 2,
              ),
            ),
            Expanded(
              child: Wrap(
                spacing: 10.w,
                runSpacing: 8.h,
                children: transactions
                    .map((item) => _Transaction(transaction: item))
                    .toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _GridTransactions extends StatelessWidget {
  final double totalValue;
  final List<TransactionModel> transactions;
  const _GridTransactions({
    required this.totalValue,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12.w,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: ReportAnalysisChart(radius: 100.r,totalValue: totalValue, transactions: transactions),
        ),
        CustomGrid(
          crossAxisCount: 3,
          items: transactions,
          childAspectRatio: 4.8,
          padding: EdgeInsets.zero,
          itemBuilder: (context, item) => _Transaction(transaction: item),
        ),
      ],
    );
  }
}

class _Transaction extends StatelessWidget {
  final TransactionModel transaction;
  const _Transaction({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final category = transaction.categoryId.getCategory();
    return Row(
      spacing: 8.w,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 20.w,
          height: 20.w,
          decoration: BoxDecoration(
            color: Color(category.color),
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
        Expanded(
          child: CustomText(text: category.name, size: 15.sp, type: Type.header)
        ),
      ],
    );
  }
}

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../../const/app_data.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../core/widgets/custom_list.dart';
import '../../../../../core/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/category_extension.dart';
import '../../../../transactions/data/model/transaction_model.dart';

class ReportAnalysisCard extends StatelessWidget {
  final double radius;
  final double totalValue;
  final List<TransactionModel> transactions;
  const ReportAnalysisCard({
    super.key,
    this.radius = 100,
    required this.totalValue,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.none,
      decoration: BoxDecoration(
        boxShadow: defaultBoxShadow,
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        children: [
          CustomText(text: 'Analysis', size: 18.sp, type: Type.header),
          Row(
            spacing: 16.h,
            children: [
              _Chart(
                radius: 50.r,
                totalValue: totalValue,
                transactions: transactions,
              ),
              Expanded(
                child: _Transactions(
                  totalValue: totalValue,
                  transactions: transactions,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Chart extends StatelessWidget {
  final double radius;
  final double totalValue;
  final List<TransactionModel> transactions;
  const _Chart({
    required this.radius,
    required this.totalValue,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: radius.r * 2,
        width: radius.r * 2,
        child: PieChart(
          PieChartData(
            startDegreeOffset: -90,
            centerSpaceRadius: 0,
            sectionsSpace: 1,
            borderData: FlBorderData(show: false),
            pieTouchData: PieTouchData(enabled: false),
            sections: transactions
                .map(
                  (item) => _pieChartItem(
                    item: item,
                    radius: radius,
                    totalAmount: totalValue,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

PieChartSectionData _pieChartItem({
  required double radius,
  required double totalAmount,
  required TransactionModel item,
}) {
  final chartValue = item.amount / totalAmount * 100;
  final visualValue = chartValue <= 0
      ? 0.0
      : math.pow(chartValue, 0.68).toDouble() + 2.5;
  return PieChartSectionData(
    radius: radius,
    value: visualValue,
    color: Color(item.categoryId.getCategory().color),
    title: '${chartValue.toStringAsFixed(1)}%',
    titleStyle: Styles.textStyle700.copyWith(
      fontSize: 14.sp,
      color: Colors.white,
    ),
  );
}

class _Transactions extends StatelessWidget {
  final double totalValue;
  final List<TransactionModel> transactions;
  const _Transactions({required this.totalValue, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return CustomList(
      items: transactions,
      padding: EdgeInsets.zero,
      scrollPhysics: const NeverScrollableScrollPhysics(),
      itemBuilder: (item) => _Transaction(
        transaction: item,
        progress: item.amount / totalValue * 100,
      ),
    );
  }
}

class _Transaction extends StatelessWidget {
  final double progress;
  final TransactionModel transaction;
  const _Transaction({required this.progress, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final category = transaction.categoryId.getCategory();
    return Row(
      spacing: 8.w,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 18.w,
          height: 18.w,
          decoration: BoxDecoration(
            color: Color(category.color),
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: CustomText(
                  text: category.name,
                  size: 15.sp,
                  type: Type.header,
                ),
              ),
              CustomText(
                text: '${progress.toStringAsFixed(1)} % ',
                size: 15.sp,
                type: Type.header,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

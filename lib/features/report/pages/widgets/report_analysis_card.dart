import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/extensions/category_extension.dart';
import '../../../../core/extensions/transaction_extension.dart';
import '../../../transactions/data/model/transaction_model.dart';

class ReportAnalysisCard extends StatelessWidget {
  final double totalValue;
  final List<TransactionModel> transactions;
  const ReportAnalysisCard({
    super.key,
    required this.totalValue,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    var transactions = this.transactions.sortByAmount();
    return Row(
      spacing: 10.w,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: _Chart(
            totalValue: totalValue,
            transactions: transactions.sortByAmount(),
          ),
        ),
        Expanded(
          child: _Transactions(transactions: transactions.sortByAmount()),
        ),
      ],
    );
  }
}

class _Chart extends StatelessWidget {
  final double totalValue;
  final List<TransactionModel> transactions;
  const _Chart({required this.totalValue, required this.transactions});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final radius = constraints.maxHeight / 2.5;
        return PieChart(
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
        );
      },
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
  final List<TransactionModel> transactions;
  const _Transactions({required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.w,
      runSpacing: 8.h,
      children: transactions
          .map((item) => _Transaction(transaction: item))
          .toList(),
    );
  }
}

class _Transaction extends StatelessWidget {
  final TransactionModel transaction;
  const _Transaction({required this.transaction});

  @override
  Widget build(BuildContext context) {
    var category = transaction.categoryId.getCategory();
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
        CustomText(text: category.name, size: 15.sp, type: Type.header),
      ],
    );
  }
}

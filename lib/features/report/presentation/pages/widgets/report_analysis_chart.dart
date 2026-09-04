import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../../core/utils/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/category_extension.dart';
import '../../../../transactions/data/model/transaction_model.dart';

class ReportAnalysisChart extends StatelessWidget {
  final double radius;
  final double totalValue;
  final List<TransactionModel> transactions;
  const ReportAnalysisChart({
    super.key,
    this.radius = 100,
    required this.totalValue,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    return _Chart(
      radius: radius,
      totalValue: totalValue,
      transactions: transactions,
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
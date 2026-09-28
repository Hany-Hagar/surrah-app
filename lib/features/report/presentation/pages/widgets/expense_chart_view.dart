import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/theme.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../generated/l10n.dart';

class ExpenseChartView extends StatelessWidget {
  final List<WeeklyExpense> weeks;

  const ExpenseChartView({super.key, required this.weeks});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = S.of(context);

    final points = weeks.isEmpty
        ? List.generate(4, (i) => WeeklyExpense(label: 'W${i + 1}', amount: 0))
        : weeks;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(theme, s),
          const SizedBox(height: 28),
          SizedBox(height: 260, child: _buildChart(theme, points)),
        ],
      ),
    );
  }

  Widget _buildHeader(ThemeData theme, S s) {
    final onSurface = theme.colorScheme.onSurface;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: s.expenseOverview,
                size: 20.sp,
                type: Type.header,
                color: onSurface,
                maxLines: 2,
              ),
              const SizedBox(height: 4),
              CustomText(
                text: s.expenseTrendSubtitle,
                size: 13.sp,
                type: Type.medium,
                color: AppTheme.inactiveGrey,
                maxLines: 2,
              ),
            ],
          ),
        ),
        _buildLegendChip(onSurface, s),
      ],
    );
  }

  Widget _buildLegendChip(Color onSurface, S s) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.secondary.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircleAvatar(radius: 5, backgroundColor: AppTheme.secondary),
          const SizedBox(width: 8),
          CustomText(
            text: s.expensesChip,
            size: 14.sp,
            type: Type.overMedium,
            color: onSurface,
          ),
        ],
      ),
    );
  }

  Widget _buildChart(ThemeData theme, List<WeeklyExpense> points) {
    final maxAmount = points.map((p) => p.amount).reduce(math.max);
    final step = _niceStep(maxAmount);
    final chartMaxY =
        maxAmount == 0 ? 1000.0 : step * (maxAmount * 1.15 / step).ceil();

    final spots = List.generate(
      points.length,
      (i) => FlSpot(i.toDouble(), points[i].amount),
    );
    final peakIndex = _peakIndex(points);
    final lineBar = _buildLine(theme, spots, peakIndex);

    return LineChart(
      LineChartData(
        minX: 0,
        maxX: (points.length - 1).toDouble(),
        minY: 0,
        maxY: chartMaxY,
        gridData: _buildGridData(step),
        borderData: FlBorderData(show: false),
        titlesData: _buildTitlesData(theme, points, step),
        lineTouchData: _buildTouchData(points),
        lineBarsData: [lineBar],
        showingTooltipIndicators: maxAmount > 0
            ? [
                ShowingTooltipIndicators([
                  LineBarSpot(lineBar, 0, spots[peakIndex]),
                ]),
              ]
            : [],
      ),
    );
  }

  LineChartBarData _buildLine(
    ThemeData theme,
    List<FlSpot> spots,
    int peakIndex,
  ) {
    return LineChartBarData(
      spots: spots,
      isCurved: true,
      preventCurveOverShooting: true,
      color: AppTheme.secondary,
      barWidth: 3,
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, bar, index) => FlDotCirclePainter(
          radius: index == peakIndex ? 6 : 4,
          color: theme.cardColor,
          strokeWidth: 3,
          strokeColor: AppTheme.secondary,
        ),
      ),
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppTheme.secondary.withValues(alpha: 0.35),
            AppTheme.secondary.withValues(alpha: 0.02),
          ],
        ),
      ),
    );
  }

  FlGridData _buildGridData(double step) {
    return FlGridData(
      show: true,
      drawVerticalLine: false,
      horizontalInterval: step,
      getDrawingHorizontalLine: (value) => FlLine(
        color: AppTheme.inactiveGrey.withValues(alpha: 0.2),
        strokeWidth: 1,
        dashArray: [4, 4],
      ),
    );
  }

  FlTitlesData _buildTitlesData(
    ThemeData theme,
    List<WeeklyExpense> points,
    double step,
  ) {
    return FlTitlesData(
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 44,
          interval: step,
          getTitlesWidget: (value, meta) => CustomText(
            text: _formatAmount(value),
            size: 11.sp,
            type: Type.medium,
            color: AppTheme.inactiveGrey,
          ),
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 48,
          interval: points.length > 8 ? 2 : 1,
          getTitlesWidget: (value, meta) =>
              _buildBottomTitle(theme, points, value),
        ),
      ),
    );
  }

  Widget _buildBottomTitle(
    ThemeData theme,
    List<WeeklyExpense> points,
    double value,
  ) {
    if (value != value.roundToDouble()) return const SizedBox();
    final index = value.toInt();
    if (index < 0 || index >= points.length) return const SizedBox();

    final point = points[index];

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            text: point.label,
            size: 13.sp,
            type: Type.overMedium,
            color: theme.colorScheme.onSurface,
          ),
          if (point.subLabel.isNotEmpty)
            CustomText(
              text: point.subLabel,
              size: 11.sp,
              type: Type.medium,
              color: AppTheme.inactiveGrey,
            ),
        ],
      ),
    );
  }

  LineTouchData _buildTouchData(List<WeeklyExpense> points) {
    return LineTouchData(
      enabled: false,
      touchTooltipData: LineTouchTooltipData(
        getTooltipColor: (spot) => AppTheme.secondary,
        tooltipPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        getTooltipItems: (spots) {
          return spots.map((spot) {
            final point = points[spot.x.toInt()];
            return LineTooltipItem(
              '${point.label}\n${_formatAmount(point.amount)}',
              const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: AppTheme.primary,
              ),
            );
          }).toList();
        },
      ),
    );
  }

  int _peakIndex(List<WeeklyExpense> points) {
    var index = 0;
    for (var i = 1; i < points.length; i++) {
      if (points[i].amount > points[index].amount) index = i;
    }
    return index;
  }

  double _niceStep(double maxAmount) {
    if (maxAmount <= 0) return 250;
    final rough = maxAmount / 4;
    final magnitude =
        math.pow(10, (math.log(rough) / math.ln10).floor()).toDouble();
    final residual = rough / magnitude;
    final factor = residual <= 1
        ? 1
        : residual <= 2
            ? 2
            : residual <= 5
                ? 5
                : 10;
    return factor * magnitude;
  }

  String _formatAmount(double value) {
    if (value >= 1000) {
      final k = value / 1000;
      return '\$${k.toStringAsFixed(k == k.roundToDouble() ? 0 : 1)}k';
    }
    return '\$${value.toStringAsFixed(0)}';
  }
}

class WeeklyExpense {
  final String label;
  final String subLabel;
  final double amount;

  const WeeklyExpense({
    required this.label,
    required this.amount,
    this.subLabel = '',
  });
}
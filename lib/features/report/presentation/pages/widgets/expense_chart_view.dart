import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/theme.dart';
import '../../../../../core/widgets/custom_text.dart';

class ExpenseChartView extends StatelessWidget {
  final List<WeeklyExpense> weeks;

  const ExpenseChartView({super.key, required this.weeks});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final displayWeeks = weeks.isEmpty
        ? const [
            WeeklyExpense(label: 'Week 1', amount: 0),
            WeeklyExpense(label: 'Week 2', amount: 0),
            WeeklyExpense(label: 'Week 3', amount: 0),
            WeeklyExpense(label: 'Week 4', amount: 0),
          ]
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
          _buildHeader(theme),
          const SizedBox(height: 28),
          SizedBox(height: 260, child: _buildChart(theme, displayWeeks)),
        ],
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    final onSurface = theme.colorScheme.onSurface;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Expense Overview",
                size: 20.sp,
                type: Type.header,
                color: onSurface,
              ),
              const SizedBox(height: 4),
              CustomText(
                text: "Your spending during this month",
                size: 13.sp,
                type: Type.medium,
                color: AppTheme.inactiveGrey,
              ),
            ],
          ),
        ),
        _buildLegendChip(onSurface),
      ],
    );
  }

  Widget _buildLegendChip(Color onSurface) {
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
            text: "Expenses",
            size: 14.sp,
            type: Type.overMedium,
            color: onSurface,
          ),
        ],
      ),
    );
  }

  Widget _buildChart(ThemeData theme, List<WeeklyExpense> displayWeeks) {
    final maxAmount =
        displayWeeks.map((w) => w.amount).reduce((a, b) => a > b ? a : b);
    final chartMaxY = maxAmount == 0 ? 1000.0 : maxAmount * 1.15;

    return BarChart(
      BarChartData(
        maxY: chartMaxY,
        alignment: BarChartAlignment.spaceEvenly,
        gridData: _buildGridData(),
        borderData: FlBorderData(show: false),
        titlesData: _buildTitlesData(theme, displayWeeks),
        barTouchData: _buildTouchData(),
        barGroups: _buildBarGroups(theme, displayWeeks, maxAmount),
      ),
    );
  }

  FlGridData _buildGridData() {
    return FlGridData(
      show: true,
      drawVerticalLine: false,
      horizontalInterval: 1000,
      getDrawingHorizontalLine: (value) => FlLine(
        color: AppTheme.inactiveGrey.withValues(alpha: 0.2),
        strokeWidth: 1,
        dashArray: [4, 4],
      ),
    );
  }

  FlTitlesData _buildTitlesData(
    ThemeData theme,
    List<WeeklyExpense> displayWeeks,
  ) {
    final onSurface = theme.colorScheme.onSurface;

    return FlTitlesData(
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles:
          const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 40,
          interval: 1000,
          getTitlesWidget: (value, meta) => CustomText(
            text: "\$${(value / 1000).toStringAsFixed(0)}k",
            size: 12.sp,
            type: Type.medium,
            color: AppTheme.inactiveGrey,
          ),
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 32,
          getTitlesWidget: (value, meta) {
            final index = value.toInt();
            if (index < 0 || index >= displayWeeks.length) {
              return const SizedBox();
            }
            return Padding(
              padding: const EdgeInsets.only(top: 8),
              child: CustomText(
                text: displayWeeks[index].label,
                size: 14.sp,
                type: Type.medium,
                color: onSurface,
              ),
            );
          },
        ),
      ),
    );
  }

  BarTouchData _buildTouchData() {
    return BarTouchData(
      enabled: false,
      touchTooltipData: BarTouchTooltipData(
        getTooltipColor: (group) => AppTheme.secondary,
        tooltipPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        tooltipMargin: 8,
        getTooltipItem: (group, groupIndex, rod, rodIndex) {
          final value = "\$${(rod.toY / 1000).toStringAsFixed(1)}k";
          return BarTooltipItem(
            value,
            const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppTheme.primary,
            ),
          );
        },
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups(
    ThemeData theme,
    List<WeeklyExpense> displayWeeks,
    double maxAmount,
  ) {
    return List.generate(displayWeeks.length, (i) {
      final amount = displayWeeks[i].amount;
      final ratio = maxAmount == 0 ? 0.0 : (amount / maxAmount);
      final opacity =
          maxAmount == 0 ? 0.15 : (0.2 + (ratio * 0.8)).clamp(0.15, 1.0);

      return BarChartGroupData(
        x: i,
        showingTooltipIndicators: amount > 0 ? [0] : [],
        barRods: [
          BarChartRodData(
            toY: amount,
            width: 42,
            color: AppTheme.secondary.withValues(alpha: opacity),
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(8)),
          ),
        ],
      );
    });
  }
}

class WeeklyExpense {
  final String label;
  final double amount;

  const WeeklyExpense({required this.label, required this.amount});
}
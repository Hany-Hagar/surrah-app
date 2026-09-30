import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../generated/l10n.dart';
import 'expense_breakdown_view.dart';

class IncomeBreakdownView extends StatelessWidget {
  final List<CategoryExpense> incomeBreakdown;

  const IncomeBreakdownView({super.key, required this.incomeBreakdown});

  double get _totalIncome =>
      incomeBreakdown.fold(0, (sum, c) => sum + c.amount);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = S.of(context);

    if (incomeBreakdown.isEmpty) {
      return _buildEmptyState(theme, s);
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(s),
          const SizedBox(height: 24),
          _buildBody(theme, s),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme, S s) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: CustomText(
            text: s.noIncomeThisMonth,
            size: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(S s) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Expanded so a long title never overflows the row
        Expanded(
          child: CustomText(
            text: s.incomeBreakdown,
            size: 20,
            type: Type.header,
            maxLines: 2,
          ),
        ),
        const SizedBox(width: 10),
        CustomText(
          text: s.sourcesCount(incomeBreakdown.length),
          size: 13.sp,
          type: Type.overSmall,
          opacity: FontOpacity.medium,
          maxLines: 2,
        ),
      ],
    );
  }

  Widget _buildBody(ThemeData theme, S s) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // chart 140 -> 120 to give the legend more room
        SizedBox(width: 120, height: 120, child: _buildDonutChart()),
        const SizedBox(width: 16),
        Expanded(child: _buildSourceList(s)),
      ],
    );
  }

  Widget _buildDonutChart() {
    return Stack(
      alignment: Alignment.center,
      children: [
        PieChart(
          PieChartData(
            sectionsSpace: 2,
            centerSpaceRadius: 40, // was 48
            sections: incomeBreakdown.map((c) {
              return PieChartSectionData(
                value: c.amount,
                color: Color(c.category.color),
                radius: 20, // was 22
                showTitle: false,
              );
            }).toList(),
          ),
        ),
        _buildCenterLabel(),
      ],
    );
  }

  Widget _buildCenterLabel() {
    return Builder(
      builder: (context) {
        final s = S.of(context);
        // FittedBox so the label always fits inside the hole
        return SizedBox(
          width: 68,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  text: s.totalIncomeLabel,
                  size: 9,
                  type: Type.overSmall,
                  opacity: FontOpacity.medium,
                  letterSpacing: 0.5,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
                const SizedBox(height: 4),
                CustomText(
                  text: "\$${_totalIncome.toStringAsFixed(0)}",
                  size: 16.sp,
                  type: Type.header,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSourceList(S s) {
    return Column(
      children: incomeBreakdown.map((c) => _buildSourceRow(c)).toList(),
    );
  }

  Widget _buildSourceRow(CategoryExpense c) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: Color(c.category.color),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: CustomText(
              text: c.category.name,
              size: 13,
              type: Type.overMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // gap between the name and the numbers
          const SizedBox(width: 8),
          // percentage above the amount instead of side by side
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                text: "${c.percentage.toStringAsFixed(0)}%",
                size: 13,
                type: Type.header,
                maxLines: 1,
              ),
              CustomText(
                text: "\$${c.amount.toStringAsFixed(0)}",
                size: 12,
                type: Type.overSmall,
                opacity: FontOpacity.medium,
                maxLines: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
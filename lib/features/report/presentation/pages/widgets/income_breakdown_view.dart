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
        CustomText(
          text: s.incomeBreakdown,
          size: 20,
          type: Type.header,
        ),
        CustomText(
          text: s.sourcesCount(incomeBreakdown.length),
          size: 13.sp,
          type: Type.overSmall,
          opacity: FontOpacity.medium,
        ),
      ],
    );
  }

  Widget _buildBody(ThemeData theme, S s) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: 140, height: 140, child: _buildDonutChart()),
        const SizedBox(width: 20),
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
            centerSpaceRadius: 48,
            sections: incomeBreakdown.map((c) {
              return PieChartSectionData(
                value: c.amount,
                color: Color(c.category.color),
                radius: 22,
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
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              text: s.totalIncomeLabel,
              size: 9,
              type: Type.overSmall,
              opacity: FontOpacity.medium,
              letterSpacing: 0.5,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            CustomText(
              text: "\$${_totalIncome.toStringAsFixed(0)}",
              size: 16.sp,
              type: Type.header,
            ),
          ],
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
            ),
          ),
          CustomText(
            text: "\$${c.amount.toStringAsFixed(0)}",
            size: 12,
            type: Type.overSmall,
            opacity: FontOpacity.medium,
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 34,
            child: CustomText(
              text: "${c.percentage.toStringAsFixed(0)}%",
              size: 13,
              type: Type.header,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
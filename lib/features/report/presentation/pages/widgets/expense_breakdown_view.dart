import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:surrah/core/utils/theme.dart';
import 'package:surrah/features/categories/data/models/category_model.dart';
import '../../../../../core/widgets/custom_text.dart';

class ExpenseBreakdownView extends StatelessWidget {
  final List<CategoryExpense> categoryExpenses;
  final double totalExpenses;

  const ExpenseBreakdownView({
    super.key,
    required this.categoryExpenses,
    required this.totalExpenses,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (categoryExpenses.isEmpty) {
      return _buildEmptyState(theme);
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
          _buildHeader(theme),
          const SizedBox(height: 24),
          _buildBody(theme),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
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
            text: "No expenses for this month",
            size: 14,
            type: Type.medium,
            color: AppTheme.inactiveGrey,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: "Expense Breakdown",
          size: 18,
          type: Type.header,
          color: theme.colorScheme.onSurface,
        ),
        CustomText(
          text: "${categoryExpenses.length} Categories",
          size: 13,
          type: Type.medium,
          color: AppTheme.inactiveGrey,
        ),
      ],
    );
  }

  Widget _buildBody(ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: 140, height: 140, child: _buildDonutChart(theme)),
        const SizedBox(width: 20),
        Expanded(child: _buildCategoryList(theme)),
      ],
    );
  }

  Widget _buildDonutChart(ThemeData theme) {
    return Stack(
      alignment: Alignment.center,
      children: [
        PieChart(
          PieChartData(
            sectionsSpace: 2,
            centerSpaceRadius: 48,
            sections: categoryExpenses.map((c) {
              return PieChartSectionData(
                value: c.amount,
                color: Color(c.category.color),
                radius: 22,
                showTitle: false,
              );
            }).toList(),
          ),
        ),
        _buildCenterLabel(theme),
      ],
    );
  }

  Widget _buildCenterLabel(ThemeData theme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomText(
          text: "TOTAL EXPENSES",
          size: 9,
          type: Type.overSmall,
          color: AppTheme.inactiveGrey,
          letterSpacing: 0.5,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        CustomText(
          text: "\$${totalExpenses.toStringAsFixed(0)}",
          size: 16,
          type: Type.header,
          color: theme.colorScheme.onSurface,
        ),
      ],
    );
  }

  Widget _buildCategoryList(ThemeData theme) {
    return Column(
      children:
          categoryExpenses.map((c) => _buildCategoryRow(theme, c)).toList(),
    );
  }

  Widget _buildCategoryRow(ThemeData theme, CategoryExpense c) {
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
              color: theme.colorScheme.onSurface,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          CustomText(
            text: "\$${c.amount.toStringAsFixed(0)}",
            size: 12,
            type: Type.medium,
            color: AppTheme.inactiveGrey,
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 34,
            child: CustomText(
              text: "${c.percentage.toStringAsFixed(0)}%",
              size: 13,
              type: Type.header,
              color: theme.colorScheme.onSurface,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryExpense {
  final CategoryModel category;
  final double amount;
  final double percentage;

  const CategoryExpense({
    required this.category,
    required this.amount,
    required this.percentage,
  });
}
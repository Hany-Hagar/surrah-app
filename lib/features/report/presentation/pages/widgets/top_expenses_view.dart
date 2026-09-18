import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:intl/intl.dart';
import 'package:surrah/core/utils/theme.dart';
import 'package:surrah/core/widgets/custom_text.dart';
import 'package:surrah/features/categories/data/models/category_model.dart';
import 'package:surrah/features/transactions/data/model/transaction_model.dart';

class TopExpensesView extends StatelessWidget {
  final List<TopExpenseItem> topExpenses;
  final VoidCallback? onViewAll;

  const TopExpensesView({
    super.key,
    required this.topExpenses,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (topExpenses.isEmpty) {
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
          _buildHeader(),
          const SizedBox(height: 16),
          ..._buildList(),
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
      child: const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: CustomText(
            text: "No expenses for this month",
            size: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "Top Expenses",
              size: 18,
              type: Type.header,
            ),
            SizedBox(height: 4),
            CustomText(
              text: "Highest individual transactions",
              size: 12,
              type: Type.overSmall,
              opacity: FontOpacity.medium,
            ),
          ],
        ),
        InkWell(
          onTap: onViewAll,
          child: const CustomText(
            text: "View all",
            size: 13,
            type: Type.overMedium,
            color: AppTheme.secondary,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildList() {
    return topExpenses.map((item) => _buildExpenseTile(item)).toList();
  }

  Widget _buildExpenseTile(TopExpenseItem item) {
    final dateLabel =
        DateFormat('MMM dd, yyyy').format(item.transaction.createdAt);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          _buildIcon(item.category),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: item.transaction.notes.isNotEmpty
                      ? item.transaction.notes
                      : item.category.name,
                  size: 14,
                  type: Type.overMedium,
                ),
                const SizedBox(height: 2),
                CustomText(
                  text: "${item.category.name} • $dateLabel",
                  size: 12,
                  type: Type.overSmall,
                  opacity: FontOpacity.medium,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomText(
                text: "-\$${item.transaction.amount.toStringAsFixed(0)}",
                size: 14,
                type: Type.header,
                color: Colors.redAccent,
              ),
              const SizedBox(height: 2),
              CustomText(
                text: "Expense",
                size: 11,
                type: Type.overSmall,
                opacity: FontOpacity.medium,
              ),
            ],
          ),
        ],
      ),
    );
  }


}
Widget _buildIcon(CategoryModel category) {
  return Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(
      color: Color(category.color).withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Icon(
      _iconFromId(category.iconId),
      color: Color(category.color),
      size: 18,
    ),
  );
}

IconData _iconFromId(String iconId) {
  switch (iconId) {
    case 'food':
      return IconBroken.Bag_2;
    case 'bills':
      return IconBroken.Danger;
    case 'shopping':
      return IconBroken.Bag;
    case 'transport':
      return IconBroken.Location;
    case 'entertainment':
      return IconBroken.Game;
    case 'health':
      return IconBroken.Heart;
    case 'education':
      return IconBroken.Paper;
    case 'salary':
      return IconBroken.Wallet;
    default:
      return IconBroken.More_Circle;
  }
}

class TopExpenseItem {
  final TransactionModel transaction;
  final CategoryModel category;

  const TopExpenseItem({
    required this.transaction,
    required this.category,
  });
}
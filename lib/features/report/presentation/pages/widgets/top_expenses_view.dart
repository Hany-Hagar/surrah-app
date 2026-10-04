import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:surrah/core/utils/theme.dart';
import 'package:surrah/core/widgets/custom_category_icon.dart';
import 'package:surrah/core/widgets/custom_text.dart';
import 'package:surrah/features/categories/data/models/category_model.dart';
import 'package:surrah/features/transactions/data/model/transaction_model.dart';
import 'package:surrah/generated/l10n.dart';

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
    final s = S.of(context);

    if (topExpenses.isEmpty) {
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
          const SizedBox(height: 16),
          ..._buildList(s),
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
            text: s.noExpensesThisMonth,
            size: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(S s) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: s.topExpenses,
              size: 20,
              type: Type.header,
            ),
            const SizedBox(height: 4),
            CustomText(
              text: s.topExpensesSubtitle,
              size: 12,
              type: Type.overSmall,
              opacity: FontOpacity.medium,
              maxLines: 2,
            ),
          ],
        ),
        InkWell(
          onTap: onViewAll,
          child: CustomText(
            text: s.viewAll,
            size: 13,
            type: Type.overMedium,
            color: AppTheme.secondary,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildList(S s) {
    return topExpenses.map((item) => _buildExpenseTile(item, s)).toList();
  }

  Widget _buildExpenseTile(TopExpenseItem item, S s) {
    final dateLabel =
        DateFormat('MMM dd, yyyy').format(item.transaction.createdAt);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CustomCategoryIcon(
            category: item.category,
            size: 40,
          ),
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
                text: s.expenseTag,
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

class TopExpenseItem {
  final TransactionModel transaction;
  final CategoryModel category;

  const TopExpenseItem({
    required this.transaction,
    required this.category,
  });
}
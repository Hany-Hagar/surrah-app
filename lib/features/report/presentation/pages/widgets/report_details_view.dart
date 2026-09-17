// ignore_for_file: non_constant_identifier_names, unused_local_variable, unused_element_parameter

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:intl/intl.dart';
import 'package:surrah/features/report/presentation/manager/report_cubit.dart';
import 'package:surrah/features/report/presentation/manager/report_state.dart';
import 'package:surrah/features/report/presentation/pages/widgets/expense_chart_view.dart';
import '../../../../../core/widgets/custom_text.dart';

class ReportDetailsView extends StatelessWidget {
  const ReportDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportCubit, ReportState>(
      builder: (context, state) {
        final reportState = state is ReportMonthSelected ? state : null;
        final selectedMonth = reportState?.selectedMonth ?? DateTime.now();

        return Column(
          children: [
            const SizedBox(height: 3),
            MonthNavigator(
              selectedMonth: selectedMonth,
              onPrevious: () {
                final previousMonth = DateTime(
                  selectedMonth.year,
                  selectedMonth.month - 1,
                );
                context.read<ReportCubit>().selectMonth(previousMonth);
              },
              onNext: () {
                final nextMonth = DateTime(
                  selectedMonth.year,
                  selectedMonth.month + 1,
                );
                context.read<ReportCubit>().selectMonth(nextMonth);
              },
              onMonthLabelTap: () {
                _pickMonth(context, selectedMonth);
              },
            ),
            const SizedBox(height: 8),
            SummaryCardsRow(
              salary: reportState?.salary ?? 0,
              totalExpenses: reportState?.totalExpenses ?? 0,
              remaining: reportState?.remaining ?? 0,
              expensePercentage: reportState?.expensePercentage ?? 0,
              savedPercentage: reportState?.savedPercentage ?? 0,
            ),
            const SizedBox(height: 8),
            ExpenseChartView(
              weeks: reportState?.weeklyExpenses ?? [],
            ),
          ],
        );
      },
    );
  }
}

class MonthNavigator extends StatelessWidget {
  const MonthNavigator({
    super.key,
    required this.selectedMonth,
    required this.onPrevious,
    required this.onNext,
    required this.onMonthLabelTap,
  });

  final DateTime selectedMonth;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onMonthLabelTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentLocale = Localizations.localeOf(context).languageCode;
    final monthLabel =
        DateFormat('MMMM yyyy', currentLocale).format(selectedMonth);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(IconBroken.Arrow___Left_2),
            onPressed: onPrevious,
          ),
          InkWell(
            onTap: onMonthLabelTap,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    IconBroken.Calendar,
                    size: 25.sp,
                    color: theme.colorScheme.secondary,
                  ),
                  const SizedBox(width: 8),
                  CustomText(
                    text: monthLabel,
                    size: 16.sp,
                    type: Type.header,
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(IconBroken.Arrow___Right_2),
            onPressed: onNext,
          ),
        ],
      ),
    );
  }
}

Future<void> _pickMonth(BuildContext context, DateTime current) async {
  final picked = await showDatePicker(
    context: context,
    initialDate: current,
    firstDate: DateTime(2020),
    lastDate: DateTime(2035, 12),
    initialDatePickerMode: DatePickerMode.year,
  );

  if (picked != null && context.mounted) {
    context.read<ReportCubit>().selectMonth(
      DateTime(picked.year, picked.month),
    );
  }
}

class SummaryCardsRow extends StatelessWidget {
  const SummaryCardsRow({
    super.key,
    required this.salary,
    required this.totalExpenses,
    required this.remaining,
    required this.expensePercentage,
    required this.savedPercentage,
  });

  final double salary;
  final double totalExpenses;
  final double remaining;
  final double expensePercentage;
  final double savedPercentage;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _SummaryCard(
            label: 'Salary',
            icon: Icons.add,
            amount: '\$${salary.toStringAsFixed(0)}',
            footer: 'Income',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _SummaryCard(
            label: 'Total\nExpenses',
            icon: Icons.north_east,
            amount: '\$${totalExpenses.toStringAsFixed(0)}',
            footer: '${expensePercentage.toStringAsFixed(1)}% spent',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _SummaryCard(
            label: 'Remaining',
            icon: Icons.account_balance_wallet_outlined,
            amount: '\$${remaining.toStringAsFixed(0)}',
            footer: 'Saved ${savedPercentage.toStringAsFixed(1)}%',
          ),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.label,
    required this.icon,
    required this.amount,
    required this.footer,
  });

  final String label;
  final IconData icon;
  final String amount;
  final String footer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomText(
                  text: label,
                  size: 10.sp,
                  type: Type.overMedium,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  size: 16,
                  color: theme.colorScheme.secondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          CustomText(
            text: amount,
            size: 20.sp,
            type: Type.header,
            color: theme.colorScheme.onSurface,
          ),
          const SizedBox(height: 4),
          CustomText(
            text: footer,
            size: 12.sp,
            type: Type.medium,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ],
      ),
    );
  }
}
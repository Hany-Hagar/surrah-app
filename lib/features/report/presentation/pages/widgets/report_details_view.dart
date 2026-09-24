// ignore_for_file: non_constant_identifier_names, unused_local_variable, unused_element_parameter

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:intl/intl.dart';
import 'package:surrah/features/report/presentation/manager/report_cubit.dart';
import 'package:surrah/features/report/presentation/manager/report_state.dart';
import 'package:surrah/features/report/presentation/pages/widgets/expense_breakdown_view.dart';
import 'package:surrah/features/report/presentation/pages/widgets/expense_chart_view.dart';
import 'package:surrah/features/report/presentation/pages/widgets/export_report_view.dart';
import 'package:surrah/features/report/presentation/pages/widgets/income_breakdown_view.dart';
import 'package:surrah/features/report/presentation/pages/widgets/top_expenses_view.dart';
import '../../../../../core/utils/theme.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../generated/l10n.dart';
import '../../../../transactions/presentation/pages/views/transactions_view.dart';

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

            NetBalanceCard(
              salary: reportState?.salary ?? 0,
              totalExpenses: reportState?.totalExpenses ?? 0,
              remaining: reportState?.remaining ?? 0,
            ),
            if (reportState?.incomeBreakdown.isNotEmpty ?? false) ...[
              const SizedBox(height: 8),
              IncomeBreakdownView(
                incomeBreakdown: reportState?.incomeBreakdown ?? [],
              ),
            ],
            const SizedBox(height: 8),
            ExpenseChartView(
              weeks: reportState?.weeklyExpenses ?? [],
            ),

            const SizedBox(height: 8),
            ExpenseBreakdownView(
              categoryExpenses: reportState?.categoryExpenses ?? [],
              totalExpenses: reportState?.totalExpenses ?? 0,
            ),
            const SizedBox(height: 8),
            TopExpensesView(
              topExpenses: reportState?.topExpenses ?? [],
              onViewAll: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TransactionsView()),
                );
              },
            ),
            const SizedBox(height: 8),
            ReadyForExportCard(
              transactionsCount: reportState?.monthTransactions.length ?? 0,
            ),
            const SizedBox(height: 8),
            ExportReportView(
              month: selectedMonth,
              salary: reportState?.salary ?? 0,
              totalExpenses: reportState?.totalExpenses ?? 0,
              remaining: reportState?.remaining ?? 0,
              transactions: reportState?.monthTransactions ?? [],
              categories: reportState?.categories ?? [],
              weeklyExpenses: reportState?.weeklyExpenses ?? [],
              categoryExpenses: reportState?.categoryExpenses ?? [],
              incomeEntries: reportState?.incomeEntries ?? [],
              incomeBreakdown: reportState?.incomeBreakdown ?? [],
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

class NetBalanceCard extends StatelessWidget {
  const NetBalanceCard({
    super.key,
    required this.salary,
    required this.totalExpenses,
    required this.remaining,
  });

  final double salary;
  final double totalExpenses;
  final double remaining;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = S.of(context);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20.r),
        image: const DecorationImage(
          image: AssetImage('assets/images/bg_report.jpeg'),
          fit: BoxFit.cover,
        )

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: s.thisMonth,
                size: 18.sp,
                type: Type.overMedium,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              Icon(
                IconBroken.Calendar,
                size: 18.sp,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
          SizedBox(height: 8.h),
          CustomText(
            text: s.remaining,
            size: 14.sp,
            type: Type.medium,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          SizedBox(height: 4.h),
          CustomText(
            text: '\$${remaining.toStringAsFixed(0)}',
            size: 28.sp,
            type: Type.header,
            color: theme.colorScheme.onSurface,
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _MiniStat(
                  label: s.incomeLabel,
                  amount: salary,
                  icon: Icons.arrow_upward_rounded,
                  color: Colors.green,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _MiniStat(
                  label: s.totalExpenses,
                  amount: totalExpenses,
                  icon: Icons.arrow_downward_rounded,
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({
    required this.label,
    required this.amount,
    required this.icon,
    required this.color,
  });

  final String label;
  final double amount;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(icon, size: 12.sp, color: color),
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: CustomText(
                  text: label,
                  size: 14.sp,
                  type: Type.medium,
                  color: theme.colorScheme.onSurfaceVariant,
                  maxLines: 1,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          CustomText(
            text: '\$${amount.toStringAsFixed(0)}',
            size: 16.sp,
            type: Type.header,
            color: theme.colorScheme.onSurface,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}

class ReadyForExportCard extends StatelessWidget {
  final int transactionsCount;

  const ReadyForExportCard({super.key, required this.transactionsCount});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = S.of(context);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppTheme.secondary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppTheme.secondary.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppTheme.secondary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.description_outlined,
              size: 20.sp,
              color: AppTheme.secondary,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: s.readyForExport(transactionsCount),
                  size: 14.sp,
                  type: Type.overMedium,
                  color: theme.colorScheme.onSurface,
                ),
                SizedBox(height: 4.h),
                CustomText(
                  text: s.readyForExportDescription,
                  size: 12.sp,
                  type: Type.medium,
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 1.4,
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
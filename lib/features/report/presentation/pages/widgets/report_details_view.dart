import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:intl/intl.dart';
import 'package:surrah/features/report/presentation/manager/report_cubit.dart';
import 'package:surrah/features/report/presentation/manager/report_state.dart';

class ReportDetailsView extends StatelessWidget {
  const ReportDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportCubit, ReportState>(
      builder: (context, state) {
        final selectedMonth = state is ReportMonthSelected ? 
        state.selectedMonth : DateTime.now();
        return Column(
          children: [
            const SizedBox(height: 3),
            MonthNavigator(
              selectedMonth: selectedMonth,
              onPrevious: () {
                final previousMonth = DateTime(selectedMonth.year,
                 selectedMonth.month - 1);
                context.read<ReportCubit>().selectMonth(previousMonth);
                // Handle previous month action
              },
              onNext: () {
                final nextMonth = DateTime(selectedMonth.year,
                 selectedMonth.month + 1);
                context.read<ReportCubit>().selectMonth(nextMonth);
                // Handle next month action
              },
              onMonthLabelTap: () {
                _pickMonth(context, selectedMonth);
              },
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
    @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentLocale = Localizations.localeOf(context).languageCode;
final monthLabel = DateFormat('MMMM yyyy', currentLocale).format(selectedMonth);
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
                    size: 20,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    monthLabel,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
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
    lastDate: DateTime(2030, 12),
    initialDatePickerMode: DatePickerMode.year,
    //helpText: 'اختر الشهر',
    locale: const Locale('ar'),
  );

  if (picked != null && context.mounted) {
    context.read<ReportCubit>().selectMonth(
      DateTime(picked.year, picked.month),
    );
  }
}
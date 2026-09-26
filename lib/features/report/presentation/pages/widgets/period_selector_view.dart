import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:intl/intl.dart';

import '../../../../../core/widgets/custom_text.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/report_cubit.dart';

class PeriodSelectorView extends StatelessWidget {
  const PeriodSelectorView({
    super.key,
    required this.selectedPeriod,
    required this.selectedDate,
    required this.onMonthLabelTap,
  });

  final ReportPeriod selectedPeriod;
  final DateTime selectedDate;
  final VoidCallback onMonthLabelTap;

  String _label(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;

    switch (selectedPeriod) {
      case ReportPeriod.day:
        return DateFormat('d MMMM yyyy', locale).format(selectedDate);
      case ReportPeriod.week:
        final start = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
        final end = start.add(const Duration(days: 6));
        return '${DateFormat('d MMM', locale).format(start)} - ${DateFormat('d MMM', locale).format(end)}';
      case ReportPeriod.month:
        return DateFormat('MMMM yyyy', locale).format(selectedDate);
      case ReportPeriod.year:
        return DateFormat('yyyy', locale).format(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = S.of(context);

    final tabs = <ReportPeriod, String>{
  ReportPeriod.year: s.periodYear,
  ReportPeriod.month: s.periodMonth,
  ReportPeriod.week: s.periodWeek,
  ReportPeriod.day: s.periodDay,
};

    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Row(
            children: tabs.entries.map((entry) {
              final isSelected = entry.key == selectedPeriod;
              return Expanded(
                child: _PeriodTab(
                  label: entry.value,
                  isSelected: isSelected,
                  onTap: () {
                    if (!isSelected) {
                      context.read<ReportCubit>().selectPeriod(entry.key);
                    }
                  },
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 10.h),
         
        ],
      ),
    );
  }
}

class _PeriodTab extends StatelessWidget {
  const _PeriodTab({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? theme.colorScheme.secondary : Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
        ),
        alignment: Alignment.center,
        child: CustomText(
          text: label,
          size: 13.sp,
          type: isSelected ? Type.overMedium : Type.medium,
          color: isSelected
              ? theme.colorScheme.onSecondary
              : theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
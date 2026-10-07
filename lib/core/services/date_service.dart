import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:surrah/core/widgets/custom_text.dart';

import 'dialog_service.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_plus/date_picker_plus.dart';

class DateService {
  static Future<void> show({required BuildContext context}) async {
    await DialogService.showCustomDialog(
      context: context,
      body: SizedBox(child: _Year(initialDate: DateTime.now())),
    );
  }
}

class _Year extends StatelessWidget {
  final DateTime initialDate;

  const _Year({required this.initialDate});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return YearsPicker(
      minDate: DateTime(2000),
      maxDate: DateTime.now(),
      displayedDate: initialDate,
      onDateSelected: (date) {
        Navigator.pop(context, date);
      },
      theme: DatePickerPlusTheme(
        yearsPickerTheme: YearsPickerTheme(
          cellsPadding: EdgeInsets.zero,
          selectedCellTextStyle: TextStyle(
            color: theme.colorScheme.onPrimary,
            fontSize: 16.sp,
            height: 0.8
          )
        , ),
      ),
    );
  }
}

class _Month extends StatelessWidget {
  final DateTime initialDate;
  const _Month({required this.initialDate});

  @override
  Widget build(BuildContext context) {
    return MonthPicker(
      minDate: DateTime(2000),
      maxDate: DateTime.now(),
      onDateSelected: (date) {
        Navigator.pop(context, date);
      },
    );
  }
}

class _Week extends StatelessWidget {
  final DateTime initialDate;
  const _Week({required this.initialDate});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _Month(initialDate: initialDate),
        CustomText(text: "week 1", size: 12.sp),
        CustomText(text: "week 1", size: 12.sp),
        CustomText(text: "week 1", size: 12.sp),
        CustomText(text: "week 1", size: 12.sp),
      ],
    );
  }
}

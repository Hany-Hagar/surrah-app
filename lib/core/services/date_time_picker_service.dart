import 'package:surrah/core/di/server_locator.dart';
import 'package:surrah/features/settings/presentation/manager/settings_cubit.dart';

import '../utils/theme.dart';
import '../utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

abstract class DateTimePickerService {
  static Future<DateTime?> showDateTimePicker({
    required BuildContext context,
    required DateTime initialDate,
  }) async {
    var isLight = getIt<SettingsCubit>().state.theme == ThemeMode.light;
    ThemeData theme = isLight ? AppTheme.light : AppTheme.dark;
    return await showOmniDateTimePicker(
      context: context,
      initialDate: initialDate,
      insetPadding: EdgeInsets.all(16.w),
      type: OmniDateTimePickerType.dateAndTime,
      borderRadius: BorderRadius.circular(16.r),
      theme: theme.copyWith(
        textButtonTheme: _buttonTheme(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }

  static TextButtonThemeData _buttonTheme({required Color color}) =>
      TextButtonThemeData(
        style: ButtonStyle(
          overlayColor: WidgetStateProperty.all(color),
          foregroundColor: WidgetStateProperty.all(color),
          textStyle: WidgetStateProperty.all(
            Styles.textStyle800.copyWith(color: color),
          ),
        ),
      );
}

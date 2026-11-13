import 'custom_text.dart';
import '../utils/theme.dart';
import '../../const/app_data.dart';
import '../di/server_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../features/settings/model/app_user_pref_model.dart';
import '../../features/settings/presentation/manager/settings_cubit.dart';

class CustomThemes extends StatelessWidget {
  const CustomThemes({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, AppUserPref>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(16.h),
          child: Column(
            spacing: 10.h,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: "المظهر", size: 18.sp, type: Type.header),
              _Themes(selectedMode: state.theme),
            ],
          ),
        );
      },
    );
  }
}

class _Themes extends StatelessWidget {
  final ThemeMode selectedMode;
  const _Themes({required this.selectedMode});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10.w,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Theme(mode: ThemeMode.light, selectedMode: selectedMode),
        _Theme(mode: ThemeMode.dark, selectedMode: selectedMode),
        _Theme(mode: ThemeMode.system, selectedMode: selectedMode),
      ],
    );
  }
}

class _Theme extends StatelessWidget {
  final ThemeMode mode;
  final ThemeMode selectedMode;
  const _Theme({required this.mode, required this.selectedMode});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var isSelected = mode == selectedMode;
    var color = theme.colorScheme.secondary;
    var borderColor = isSelected ? color : Colors.grey;
    return Expanded(
      child: GestureDetector(
        onTap: () => getIt<SettingsCubit>().changeTheme(mode),
        child: Container(
          padding: EdgeInsets.all(10.h),
          decoration: BoxDecoration(
            boxShadow: defaultBoxShadow(),
            borderRadius: BorderRadius.circular(8.h),
            border: Border.all(color: borderColor, width: 1.w),
          ),
          child: Column(
            children: [
              if (mode == ThemeMode.system) _SystemCard(),
              if (mode != ThemeMode.system) _Card(mode: mode),
              SizedBox(height: 4.h),
              CustomText(size: 14.sp, text: mode.name, type: Type.header),
            ],
          ),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final ThemeMode mode;
  const _Card({required this.mode});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    bool isDark = mode == ThemeMode.dark;
    var data = isDark ? AppTheme.dark : AppTheme.light;
    return Container(
      padding: EdgeInsets.all(10.h),
      decoration: BoxDecoration(
        color: data.cardColor,
        boxShadow: defaultBoxShadow(),
        borderRadius: BorderRadius.circular(8.h),
        border: Border.all(color: theme.dividerColor, width: 1.w),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Divider(
            height: 6.h,
            thickness: 8.h,
            endIndent: 24.w,
            color: theme.colorScheme.secondary,
          ),
          SizedBox(height: 10.h),
          _Divider(),
          SizedBox(height: 7.h),
          _Divider(endIndent: 20.w),
          SizedBox(height: 15.h),
        ],
      ),
    );
  }
}

class _SystemCard extends StatelessWidget {
  const _SystemCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        boxShadow: defaultBoxShadow(),
        borderRadius: BorderRadius.circular(10.h),
        border: Border.all(color: Theme.of(context).dividerColor, width: 1.w),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: AppTheme.light.cardColor,
              child: _body(context: context),
            ),
          ),
          Expanded(
            child: Container(
              color: AppTheme.dark.cardColor,
              child: _body(context: context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _body({required BuildContext context}) {
    var theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(10.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Divider(
            height: 4.h,
            thickness: 6.h,
            endIndent: 6.w,
            color: theme.colorScheme.secondary,
          ),
          SizedBox(height: 8.h),
          _Divider(),
          SizedBox(height: 4.h),
          _Divider(endIndent: 10.w),
          SizedBox(height: 22.h),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  final double? height;
  final Color? color;
  final double? endIndent;
  final double? thickness;
  const _Divider({this.height, this.color, this.endIndent, this.thickness});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color,
      endIndent: endIndent,
      height: height ?? 2.h,
      thickness: thickness ?? 4.h,
      radius: BorderRadius.circular(8.h),
    );
  }
}

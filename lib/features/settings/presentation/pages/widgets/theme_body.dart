import 'package:flutter/material.dart';
import '../../manager/settings_cubit.dart';
import '../../../../../generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/app_user_pref_model.dart';
import '../../../../../core/di/server_locator.dart';
import '../../../../../core/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeBody extends StatelessWidget {
  const ThemeBody({super.key});

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    return Padding(
      padding: EdgeInsets.all(12.r),
      child: Column(
        spacing: 5.h,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(alignment: Alignment.center, child: const _Drag()),
          CustomText(text: s.themes, size: 20.sp, type: Type.overMedium),
          const _Themes(),
          SizedBox(height: 15.h),
        ],
      ),
    );
  }
}

class _Drag extends StatelessWidget {
  const _Drag();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 4.h,
      margin: EdgeInsets.only(top: 10.h),
      decoration: BoxDecoration(
        color: Theme.of(context).disabledColor,
        borderRadius: BorderRadius.circular(2.r),
      ),
    );
  }
}

class _Themes extends StatelessWidget {
  const _Themes();
  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    return BlocBuilder<SettingsCubit, AppUserPref>(
      bloc: getIt<SettingsCubit>(),
      buildWhen: (previous, current) {
        return previous.theme != current.theme;
      },
      builder: (context, state) {
        final theme = Theme.of(context);
        final currentTheme = state.theme;
        return Container(
          height: 60.h,
          padding: EdgeInsets.all(6.r),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(4.r),
            border: Border.all(color: theme.dividerColor, width: 1),
          ),
          child: Row(
            children: [
              _Item(
                icon: Icons.lightbulb,
                title: s.lightTheme,
                value: ThemeMode.light,
                isSelected: currentTheme == ThemeMode.light,
              ),
              const _Divider(),
              _Item(
                icon: Icons.dark_mode,
                title: s.darkTheme,
                value: ThemeMode.dark,
                isSelected: currentTheme == ThemeMode.dark,
              ),
              const _Divider(),
              _Item(
                icon: Icons.brightness_4,
                title: s.systemTheme,
                value: ThemeMode.system,
                isSelected: currentTheme == ThemeMode.system,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Item extends StatelessWidget {
  final IconData icon;
  final String title;
  final ThemeMode value;
  final bool isSelected;

  const _Item({
    required this.icon,
    required this.title,
    required this.value,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = isSelected ? theme.primaryColor : Colors.transparent;
    final textColor = isSelected
        ? theme.colorScheme.onPrimary
        : theme.colorScheme.onSurface;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          getIt<SettingsCubit>().changeTheme(value);
        },
        child: AnimatedContainer(
          width: double.infinity,
          height: double.infinity,
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Row(
            spacing: 5.w,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 17.sp, color: textColor),
              CustomText(
                text: title,
                size: 16.sp,
                type: Type.overMedium,
                color: textColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.w,
      color: Theme.of(context).dividerColor,
      margin: EdgeInsets.symmetric(horizontal: 5.w),
    );
  }
}

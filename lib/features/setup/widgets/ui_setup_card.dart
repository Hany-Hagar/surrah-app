import 'package:country_flags/country_flags.dart';

import 'setup_card.dart';
import '../../../const/app_data.dart';
import '../../../generated/l10n.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/theme.dart';
import '../../../core/di/server_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/widgets/custom_text.dart';
import '../../settings/model/app_user_pref_model.dart';
import '../../../core/extensions/language_extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../settings/presentation/manager/settings_cubit.dart';

class UiSetupCard extends StatelessWidget {
  const UiSetupCard({super.key});

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    return SetupCard(
      title: s.uiSetupTitle,
      subtitle: s.uiSetupSubtitle,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16.h,
        children: [const _Theme(), const _Languages()],
      ),
    );
  }
}

class _Theme extends StatelessWidget {
  const _Theme();

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    return BlocBuilder<SettingsCubit, AppUserPref>(
      bloc: getIt<SettingsCubit>(),
      buildWhen: (previous, current) {
        return previous.theme != current.theme;
      },
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Title(title: s.themeTitle),
            SizedBox(height: 1.h),
            _ThemeItem(
              title: s.lightTheme,
              themeMode: ThemeMode.light,
              leading: _ThemeCard(themeData: AppTheme.light),
            ),
            _ThemeItem(
              title: s.darkTheme,
              themeMode: ThemeMode.dark,
              leading: _ThemeCard(themeData: AppTheme.dark),
            ),
            _ThemeItem(
              title: s.systemTheme,
              themeMode: ThemeMode.system,
              leading: const _SystemCard(),
            ),
          ],
        );
      },
    );
  }
}

class _ThemeItem extends StatelessWidget {
  final String title;
  final Widget leading;
  final ThemeMode themeMode;
  const _ThemeItem({
    required this.title,
    required this.leading,
    required this.themeMode,
  });

  @override
  Widget build(BuildContext context) {
    return _Item(
      title: title,
      leading: leading,
      onTap: () => getIt<SettingsCubit>().changeTheme(themeMode),
      isSelected: getIt<SettingsCubit>().state.theme == themeMode,
    );
  }
}

class _ThemeCard extends StatelessWidget {
  final ThemeData themeData;
  const _ThemeCard({required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 35.w,
      decoration: BoxDecoration(
        boxShadow: defaultBoxShadow(),
        color: themeData.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.r),
      ),
      margin: EdgeInsets.symmetric(vertical: 5.h),
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      child: Column(
        children: [
          Divider(color: themeData.colorScheme.secondary, thickness: 4.h),
          SizedBox(height: 5.h),
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
      width: 40.w,
      height: 35.w,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.symmetric(vertical: 5.h),
      decoration: BoxDecoration(
        boxShadow: defaultBoxShadow(),
        borderRadius: BorderRadius.circular(4.r),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(color: AppTheme.light.scaffoldBackgroundColor),
          ),
          Expanded(
            child: Container(color: AppTheme.dark.scaffoldBackgroundColor),
          ),
        ],
      ),
    );
  }
}

// Languages
class _Languages extends StatelessWidget {
  const _Languages();

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Title(title: s.languageTitle),
        SizedBox(height: 1.h),
        _LangItem(code: "ar"),
        _LangItem(code: "en"),
      ],
    );
  }
}

class _LangItem extends StatelessWidget {
  final String code;
  const _LangItem({required this.code});

  @override
  Widget build(BuildContext context) {
    var currentLang = getIt<SettingsCubit>().state.lang;
    return _Item(
      isSelected: currentLang == code,
      title: code.toLanguageName(context),
      description: code.toCuntryName(context),
      onTap: () => getIt<SettingsCubit>().changeLanguage(code),
      leading: CountryFlag.fromCountryCode(code.toFlag, theme: EmojiTheme()),
    );
  }
}

// Widgets
class _Item extends StatelessWidget {
  final String title;
  final Widget leading;
  final bool isSelected;
  final Function() onTap;
  final String? description;
  const _Item({
    this.description,
    required this.onTap,
    required this.title,
    required this.leading,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var color = isSelected ? theme.colorScheme.secondary : theme.dividerColor;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: color, width: 1.w),
        ),
        child: Row(
          spacing: 12.w,
          children: [
            leading,
            _body(title: title, description: description),
            Icon(
              size: 24.sp,
              color: color,
              isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
            ),
          ],
        ),
      ),
    );
  }

  Widget _body({required String title, String? description}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(text: title, size: 16.sp, type: Type.header),
          if (description != null)
            CustomText(
              size: 14.sp,
              height: 1.2,
              text: description,
              type: Type.overMedium,
              opacity: FontOpacity.medium,
            ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String title;
  const _Title({required this.title});

  @override
  Widget build(BuildContext context) {
    return CustomText(text: title, size: 18.sp, type: Type.header);
  }
}

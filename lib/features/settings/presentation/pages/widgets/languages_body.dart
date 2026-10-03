import 'package:flutter/material.dart';
import '../../../../../const/data.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/settings_cubit.dart';
import 'package:country_flags/country_flags.dart';
import '../../../../../core/di/server_locator.dart';
import '../../../../../core/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/language_extensions.dart';

class LanguagesBody extends StatelessWidget {
  const LanguagesBody({super.key});

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    var cubit = getIt<SettingsCubit>();
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Text(title: s.currentLanguage),
          _Item(lang: supportedLanguages.selectedLanguage(cubit.state.lang)),
          SizedBox(height: 10.h),
           _Text(title: s.otherLanguages),
          ...supportedLanguages
              .otherLanguages(cubit.state.lang)
              .map((lang) => _Item(lang: lang)),
        ],
      ),
    );
  }
}

class _Text extends StatelessWidget {
  final String title;
  const _Text({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(bottom: 5.h),
      child: CustomText(text: title, size: 18.sp, type: Type.overMedium),
    );
  }
}

class _Item extends StatelessWidget {
  final String lang;
  const _Item({required this.lang});

  @override
  Widget build(BuildContext context) {
    var cubit = getIt<SettingsCubit>();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: ListTile(
        minTileHeight: 70.h,
        horizontalTitleGap: 12.w,
        onTap: () => cubit.changeLanguage(lang),
        tileColor: Theme.of(context).cardColor,
        leading: _Leading(flag: lang.toLanguageFlag),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
        title: CustomText(
          text: lang.toLanguageName(context),
          size: 16.sp,
          type: Type.header,
        ),
        subtitle: CustomText(
          text: lang.toCuntryName(context),
          size: 14.sp,
          type: Type.overMedium,
        ),
      ),
    );
  }
}

class _Leading extends StatelessWidget {
  final String flag;
  const _Leading({required this.flag});

  @override
  Widget build(BuildContext context) {
    return CountryFlag.fromCountryCode(flag, theme: EmojiTheme());
  }
}

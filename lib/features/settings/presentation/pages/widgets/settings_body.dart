import 'theme_body.dart';
import 'settings_item.dart';
import '../views/languages_view.dart';
import 'package:flutter/material.dart';
import '../../../../../generated/l10n.dart';
import 'package:icon_broken/icon_broken.dart';
import '../../../../../core/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Theme , Language and notifications
        _Title(title: s.generalSettings),
        SizedBox(height: 10.h),
        SettingsItem(
          color: Colors.blue,
          icon: IconBroken.Activity,
          title: s.themeTitle,
          subtitle: s.themeSubtitle,
          dialogBody: ThemeBody(),
        ),
        SettingsItem(
          color: Colors.green,
          icon: IconBroken.Edit,
          title: s.languageTitle,
          subtitle: s.languageSubtitle,
          nextPage: LanguagesView(),
        ),
        SettingsItem(
          color: Colors.purple,
          icon: IconBroken.Notification,
          title: s.settingsNotificationsTitle,
          subtitle: s.settingsNotificationsSubtitle,
          nextPage: SizedBox(),
        ),
        SizedBox(height: 10.h),
        // Privacy and Contact support
        _Title(title: s.settingsPrivacySupportTitle),
        SizedBox(height: 10.h),
        SettingsItem(
          color: Colors.orange,
          icon: IconBroken.Shield_Done,
          title: s.settingsPrivacyTitle,
          subtitle: s.settingsPrivacySubtitle,
          nextPage: SizedBox(),
        ),
        SettingsItem(
          color: Colors.red,
          icon: IconBroken.Call,
          title: s.settingsSupportTitle,
          subtitle: s.settingsSupportSubtitle,
          nextPage: SizedBox(),
        ),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  final String title;
  const _Title({required this.title});

  @override
  Widget build(BuildContext context) {
    return CustomText(text: title, size: 18.sp, type: Type.overMedium);
  }
}

import 'theme_body.dart';
import 'settings_item.dart';
import '../views/languages_view.dart';
import 'package:flutter/material.dart';
import '../../manager/settings_cubit.dart';
import '../../../../../generated/l10n.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/app_user_pref_model.dart';
import '../../../../../core/di/server_locator.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/custom_switch.dart';
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
        _Title(title: s.generalSettings),
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
        _Notifications(),
        SizedBox(height: 10.h),
        _Title(title: s.settingsPrivacySupportTitle),
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
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(vertical: 10.h),
      child: CustomText(text: title, size: 18.sp, type: Type.overMedium),
    );
  }
}

class _Notifications extends StatelessWidget {
  const _Notifications();

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    return BlocBuilder<SettingsCubit, AppUserPref>(
      builder: (context, state) {
        return SettingsItem(
          color: Colors.purple,
          icon: IconBroken.Notification,
          title: s.settingsNotificationsTitle,
          subtitle: s.settingsNotificationsSubtitle,
          onTap: () => getIt<SettingsCubit>().toggleNotifications(),
          trailing: CustomSwitch(
            value: state.notificationsEnabled,
            onChanged: (value) => getIt<SettingsCubit>().toggleNotifications(),
          ),
        );
      },
    );
  }
}

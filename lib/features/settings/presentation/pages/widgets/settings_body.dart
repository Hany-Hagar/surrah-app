import 'theme_body.dart';
import 'settings_item.dart';
import '../views/languages_view.dart';
import 'package:flutter/material.dart';
import '../views/privacy_policy_view.dart';
import '../../manager/settings_cubit.dart';
import '../views/contact_support_view.dart';
import '../../../../../generated/l10n.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/app_user_pref_model.dart';
import 'package:no_screenshot/overlay_mode.dart';
import '../../../../../core/di/server_locator.dart';
import '../../../../../core/widgets/custom_text.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../../../core/widgets/custom_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/services/currency_services.dart';
import '../../../../home_widget/presentation/pages/views/home_widget_view.dart';

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
          icon: PhosphorIcons.aperture(PhosphorIconsStyle.duotone),
          title: s.themeTitle,
          subtitle: s.themeSubtitle,
          dialogBody: ThemeBody(),
        ),
        SettingsItem(
          color: Colors.green,
          icon: PhosphorIcons.translate(PhosphorIconsStyle.duotone),
          title: s.languageTitle,
          subtitle: s.languageSubtitle,
          nextPage: LanguagesView(),
        ),
        _Currency(),
        _Notifications(),
        SettingsItem(
          color: Colors.teal,
          icon: PhosphorIcons.deviceMobile(PhosphorIconsStyle.duotone),
          title: s.homeWidgetTitle,
          subtitle: s.homeWidgetSubtitle,
          nextPage: const HomeWidgetView(),
        ),
        SizedBox(height: 10.h),
        _Title(title: s.settingsPrivacySupportTitle),
        _AppAuthentication(),
        _ScreenShotProtection(),
        SettingsItem(
          color: Colors.orange,
          icon: IconBroken.Shield_Done,
          title: s.privacyTitle,
          subtitle: s.privacySubtitle,
          nextPage: PrivacyPolicyView(),
        ),
        SettingsItem(
          color: Colors.red,
          title: s.contactSupportTitle,
          icon: Icons.support_agent_outlined,
          subtitle: s.contactSupportSubtitle,
          nextPage: ContactSupportView(),
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

class _Currency extends StatelessWidget {
  const _Currency();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, AppUserPref>(
      builder: (context, state) {
        var s = S.of(context);
        var cubit = SettingsCubit.get(context);
        return SettingsItem(
          color: Colors.green,
          title: s.settingsCurrencyTitle,
          subtitle: s.settingsCurrencySubtitle,
          icon: PhosphorIcons.currencyCircleDollar(PhosphorIconsStyle.duotone),
          trailing: CurrencyServices.card(
            context: context,
            currentCurrency: state.currency,
            onSelect: (currency) {
              Navigator.pop(context);
              cubit.setCurrency(currency);
            },
          ),
        );
      },
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

class _AppAuthentication extends StatelessWidget {
  const _AppAuthentication();

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    return BlocBuilder<SettingsCubit, AppUserPref>(
      builder: (context, state) {
        var cubit = SettingsCubit.get(context);
        return cubit.state.appLockSupported
            ? SettingsItem(
                icon: IconBroken.Lock,
                color: Colors.purple,
                title: s.settingsAppLockTitle,
                subtitle: s.settingsAppLockSubtitle,
                onTap: () => cubit.toggleAppLock(),
                trailing: CustomSwitch(
                  value: state.appLockEnabled,
                  onChanged: (value) => cubit.toggleAppLock(),
                ),
              )
            : SizedBox.shrink();
      },
    );
  }
}

class _ScreenShotProtection extends StatelessWidget {
  const _ScreenShotProtection();

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    return BlocBuilder<SettingsCubit, AppUserPref>(
      builder: (context, state) {
        var cubit = SettingsCubit.get(context);
        return SettingsItem(
          color: Colors.blue,
          icon: IconBroken.Hide,
          title: s.settingsScreenshotProtectionTitle,
          subtitle: s.settingsScreenshotProtectionSubTitle,
          onTap: () => cubit.toggleScreenShotProtectionMode(),
          trailing: CustomSwitch(
            value: state.screenShotProtection == OverlayMode.secure,
            onChanged: (value) => cubit.toggleScreenShotProtectionMode(),
          ),
        );
      },
    );
  }
}

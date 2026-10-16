
import 'setup_card.dart';
import '../../../generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:no_screenshot/overlay_mode.dart';
import '../../../core/widgets/custom_switch.dart';
import '../../settings/model/app_user_pref_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../settings/presentation/manager/settings_cubit.dart';
import '../../settings/presentation/pages/widgets/settings_item.dart';

class PrivacySetupCard extends StatelessWidget {
  const PrivacySetupCard({super.key});

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    return SetupCard(
      title: s.privacySetupTitle,
      subtitle: s.privacySetupSubtitle,
      child: Column(
        spacing: 5.h,
        children: [_AppAuthentication(), _ScreenShotProtection()]),
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

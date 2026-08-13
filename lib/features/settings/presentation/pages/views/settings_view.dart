import 'package:flutter/material.dart';
import '../widgets/settings_body.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/widgets/custom_back.dart';
import 'package:surrah/core/widgets/custom_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        leading: CustomBack(),
        title: s.settingsTitle,
        subtitle: s.settingsSubtitle,
      ),
      body: Padding(
        padding:  EdgeInsets.all(16.r),
        child: SettingsBody()
      ),
    );
  }
}

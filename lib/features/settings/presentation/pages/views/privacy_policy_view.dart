import 'package:flutter/material.dart';
import '../../../../../generated/l10n.dart';
import '../widgets/privacy_policy_body.dart';
import '../../../../../core/widgets/custom_back.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: s.privacyTitle,
        subtitle: s.privacySubtitle,
        leading: CustomBack(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: PrivacyPolicyBody(),
        ),
      ),
    );
  }
}

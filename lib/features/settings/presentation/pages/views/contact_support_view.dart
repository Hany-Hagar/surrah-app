import 'package:flutter/material.dart';
import '../../../../../generated/l10n.dart';
import '../widgets/contact_support_body.dart';
import '../../../../../core/widgets/custom_back.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactSupportView extends StatelessWidget {
  const ContactSupportView({super.key});

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: s.contactSupportTitle,
        subtitle: s.contactSupportSubtitle,
        leading: CustomBack(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: ContactSupportBody(),
        ),
      ),
    );
  }
}
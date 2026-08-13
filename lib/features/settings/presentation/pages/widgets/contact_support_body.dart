import 'support_card.dart';
import 'settings_item.dart';
import 'package:flutter/material.dart';
import '../../../../../const/assets.dart';
import '../../../../../generated/l10n.dart';
import 'package:icon_broken/icon_broken.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/services/support_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactSupportBody extends StatelessWidget {
  const ContactSupportBody({super.key});

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SupportCard(
          title: s.contactSupportHeaderTitle,
          imagePath: Assets.contactSupport,
          backgroundColor: Colors.blue.shade50,
          description: s.contactSupportHeaderDescription,
        ),
        CustomText(
          text: s.contactSupportTitle,
          size: 17.sp,
          type: Type.overMedium,
        ),
        SizedBox(height: 5.h),
        SettingsItem(
          color: Colors.blue,
          icon: IconBroken.Message,
          title: s.contactSupportEmailTitle,
          subtitle: s.contactSupportEmailSubtitle,
          onTap:() => SupportService.email(context: context),
        ),
        SettingsItem(
          color: Colors.green,
          icon: IconBroken.Call,
          title: s.contactSupportPhoneTitle,
          subtitle: s.contactSupportPhoneSubtitle,
          onTap: () => SupportService.call(context: context),
        ),
        SettingsItem(
          color: Colors.teal,
          icon: IconBroken.Chat,
          title: s.contactSupportWhatsAppTitle,
          subtitle: s.contactSupportWhatsAppSubtitle,
          onTap: () => SupportService.whatsapp(context: context),
        ),
        SizedBox(height: 15.h),
        CustomText(
          text: s.contactSupportFaqTitle,
          size: 17.sp,
          type: Type.overMedium,
        ),
        SizedBox(height: 5.h),
        _FaqItem(
          question: s.contactSupportFaq1Question,
          answer: s.contactSupportFaq1Answer,
        ),
        _FaqItem(
          question: s.contactSupportFaq2Question,
          answer: s.contactSupportFaq2Answer,
        ),
        _FaqItem(
          question: s.contactSupportFaq3Question,
          answer: s.contactSupportFaq3Answer,
        ),
        _FaqItem(
          question: s.contactSupportFaq4Question,
          answer: s.contactSupportFaq4Answer,
        ),
        SupportCard(
          imagePath: Assets.contactSupport,
          title: s.contactSupportFooterTitle,
          backgroundColor: const Color(0xFFF0F6FF),
          description: s.contactSupportFooterDescription,
          trailingImagePath: Assets.twentyFourHourSupport,
        ),
        SizedBox(height: 12.h),
      ],
    );
  }
}

class _FaqItem extends StatelessWidget {
  final String question;
  final String answer;
  const _FaqItem({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    EdgeInsetsGeometry padding = EdgeInsets.symmetric(
      horizontal: 14.w,
      vertical: 0.h,
    );
    ShapeBorder shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4.r),
    );
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: ExpansionTile(
        shape: shape,
        minTileHeight: 50.h,
        tilePadding: padding,
        collapsedShape: shape,
        childrenPadding: padding,
        backgroundColor: Theme.of(context).cardColor,
        collapsedBackgroundColor: Theme.of(context).cardColor,
        title: CustomText(text: question, size: 14.sp, type: Type.overMedium),
        children: [
          SizedBox(height: 6.h),
          CustomText(
            text: answer,
            size: 13.sp,
            maxLines: 4,
            opacity: FontOpacity.medium,
          ),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }
}

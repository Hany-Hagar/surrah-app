import 'package:flutter/material.dart';
import '../../../../../generated/l10n.dart';
import 'package:icon_broken/icon_broken.dart';
import '../../../../../core/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivacyPolicyBody extends StatelessWidget {
  const PrivacyPolicyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12.h,
      children: [
        _Card(),
        _PrivacyCard(
          color: const Color(0xFF22A06B), // Data
          title: S.of(context).privacyPolicyCard1Title,
          description: S.of(context).privacyPolicyCard1Description,
          icon: IconBroken.Profile,
        ),
        _PrivacyCard(
          color: const Color(0xFF3B82F6), // Storage
          title: S.of(context).privacyPolicyCard2Title,
          description: S.of(context).privacyPolicyCard2Description,
          icon: IconBroken.Document,
        ),
        _PrivacyCard(
          color: const Color(0xFF7C3AED), // Sharing
          title: S.of(context).privacyPolicyCard3Title,
          description: S.of(context).privacyPolicyCard3Description,
          icon: IconBroken.Send,
        ),
        _PrivacyCard(
          color: const Color(0xFFF59E0B), // Security
          title: S.of(context).privacyPolicyCard4Title,
          description: S.of(context).privacyPolicyCard4Description,
          icon: IconBroken.Shield_Done,
        ),
        _PrivacyCard(
          color: const Color(0xFF10B981), // Delete
          title: S.of(context).privacyPolicyCard5Title,
          description: S.of(context).privacyPolicyCard5Description,
          icon: IconBroken.Delete,
        ),
        _PrivacyCard(
          color: const Color(0xFF2563EB), // Updates
          title: S.of(context).privacyPolicyCard6Title,
          description: S.of(context).privacyPolicyCard6Description,
          icon: IconBroken.Info_Circle,
        ),
        SizedBox(height: 12.h)
      ],
    );
  }
}

class _Card extends StatelessWidget {
  const _Card();
  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: _Item(
        spacing: 4,
        title: s.privacyPolicyCardTitle,
        description: s.privacyPolicyCardDescription,
        leading: Icon(IconBroken.Shield_Done, size: 65.sp),
      ),
    );
  }
}

class _PrivacyCard extends StatelessWidget {
  final Color color;
  final String title;
  final IconData icon;
  final String description;
  const _PrivacyCard({
    required this.color,
    required this.title,
    required this.icon,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return _Item(
      maxLines: 3,
      spacing: 12,
      title: title,
      description: description,
      padding: EdgeInsetsDirectional.all(12.r),
      trailing: _ItemLeading(icon: icon, color: color),
    );
  }
}

class _Item extends StatelessWidget {
  final Widget? leading;
  final String title;
  final String description;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;
  final int maxLines;
  final double spacing;
  const _Item({
    this.leading,
    required this.title,
    required this.description,
    this.trailing,
    this.padding,
    this.spacing = 6,
    this.maxLines = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsetsDirectional.all(12.r).copyWith(start: 6.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Row(
        spacing: spacing.w,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ?leading,
          Expanded(
            child: Column(
              spacing: 4.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: title, size: 16.sp, type: Type.overMedium),
                CustomText(
                  text: description,
                  size: 14.sp,
                  maxLines: maxLines,
                  opacity: FontOpacity.medium,
                ),
              ],
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}

class _ItemLeading extends StatelessWidget {
  final IconData icon;
  final Color color;
  const _ItemLeading({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.w,
      height: 50.h,
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Icon(icon, color: color, size: 30.sp),
    );
  }
}

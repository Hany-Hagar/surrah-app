import 'package:flutter/material.dart';
import '../../../../../const/app_data.dart';
import '../../../../../core/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double spacing;
  final Color? subtitleColor;
  final Function()? onSubtitleTap;
  final Widget body;

  const ReportCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.spacing = 10,
    this.subtitleColor,
    this.onSubtitleTap,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        boxShadow: defaultBoxShadow(),
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.h),
      ),
      child: Column(
        spacing: spacing.h,
        children: [
          _Top(
            title: title,
            subtitle: subtitle,
            onSubtitleTap: onSubtitleTap,
            subtitleColor: subtitleColor,
          ),
          body,
        ],
      ),
    );
  }
}

class _Top extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color? subtitleColor;
  final Function()? onSubtitleTap;
  const _Top({
    required this.title,
    required this.subtitle,
    this.subtitleColor,
    this.onSubtitleTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomText(text: title, size: 16.5.sp, type: Type.overMedium),
        Spacer(),
        GestureDetector(
          onTap: onSubtitleTap,
          child: CustomText(
            text: subtitle,
            size: 15.5.sp,
            type: Type.header,
            color: subtitleColor,
            opacity: subtitleColor == null
                ? FontOpacity.medium
                : FontOpacity.high,
          )
        ),
      ],
    );
  }
}

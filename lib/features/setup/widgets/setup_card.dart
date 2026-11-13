import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SetupCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;
  const SetupCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(height: 16.h),
          // CustomText(
          //   text: t.appName,
          //   size: 18.sp,
          //   type: Type.header,
          //   color: theme.colorScheme.secondary,
          // ),
          // SizedBox(height: 4.h),
          // CustomText(text: title, size: 18.sp, type: Type.header),
          // SizedBox(height: 2.h),
          // CustomText(
          //   maxLines: 2,
          //   size: 14.sp,
          //   text: subtitle,
          //   type: Type.overMedium,
          //   opacity: FontOpacity.medium,
          // ),
          SizedBox(height: 16.h),
          Expanded(child: child),
        ],
      ),
    );
  }
}

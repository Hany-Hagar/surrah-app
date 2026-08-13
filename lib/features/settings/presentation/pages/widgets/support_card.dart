import 'package:flutter/material.dart';
import '../../../../../core/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SupportCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final String description;
  final Color? backgroundColor;
  final String? trailingImagePath;
  const SupportCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.description,
    this.backgroundColor,
    this.trailingImagePath,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: _Item(
        title: title,
        description: description,
        backgroundColor: backgroundColor,
        leading: Image.asset(imagePath, width: 75.w, height: 75.w),
        trailing: trailingImagePath != null
            ? Image.asset(trailingImagePath!, width: 75.w, height: 75.w)
            : null,
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final Widget? leading;
  final String title;
  final String description;
  final Color? backgroundColor;
  final Widget? trailing;
  const _Item({
    this.leading,
    required this.title,
    required this.description,
    this.backgroundColor,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(
        vertical: 24.h,
        horizontal: 12.w,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Row(
        spacing: 12.w,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ?leading,
          Expanded(
            child: Column(
              spacing: 4.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: title, size: 16.sp, type: Type.overMedium),
                CustomText(text: description, size: 14.sp, maxLines: 5),
              ],
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}

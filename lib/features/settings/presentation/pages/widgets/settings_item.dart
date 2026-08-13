import 'package:flutter/material.dart';
import '../../../../../core/utils/nav_to.dart';
import '../../../../../core/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsItem extends StatelessWidget {
  final Color color;
  final String title;
  final IconData icon;
  final String subtitle;
  final Widget? nextPage;
  final Widget? trailing;
  final Widget? dialogBody;
  final Function()? onTap;
  const SettingsItem({
    super.key,
    required this.color,
    required this.title,
    required this.icon,
    required this.subtitle,
    this.nextPage,
    this.trailing,
    this.dialogBody,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          onTap ??
          () {
            if (nextPage != null) {
              NavTo.push(context: context, nextPage: nextPage!);
            } else if (dialogBody != null) {
              showModalBottomSheet(
                context: context,
                isDismissible: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(4.r),
                  ),
                ),
                builder: (context) => dialogBody!,
              );
            }
          },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: ListTile(
          minTileHeight: 70.h,
          horizontalTitleGap: 12.w,
          contentPadding: getContentPadding(),
          tileColor: Theme.of(context).cardColor,
          leading: _ItemLeading(icon: icon, color: color),
          title: CustomText(text: title, size: 14.sp, type: Type.overMedium),
          subtitle: CustomText(
            text: subtitle,
            size: 12.sp,
            opacity: FontOpacity.medium,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.r),
          ),
          trailing: trailing ?? Icon(Icons.arrow_forward_ios, size: 16.sp),
        ),
      ),
    );
  }

  EdgeInsetsGeometry getContentPadding() {
    if (trailing == null) {
      return EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h);
    } else {
      return EdgeInsetsDirectional.only(
        start: 12.w,
        end: 0.w,
        top: 5.h,
        bottom: 5.h,
      );
    }
  }
}

class _ItemLeading extends StatelessWidget {
  final IconData icon;
  final Color color;
  const _ItemLeading({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Icon(icon, color: color, size: 24.sp),
    );
  }
}

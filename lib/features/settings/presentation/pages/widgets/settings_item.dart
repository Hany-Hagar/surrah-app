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
  final Widget? dialogBody;
  const SettingsItem({
    super.key,
    required this.color,
    required this.title,
    required this.icon,
    required this.subtitle,
    this.nextPage,
    this.dialogBody,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (nextPage != null) {
          NavTo.push(context: context, nextPage: nextPage!);
        } else if (dialogBody != null) {
          showModalBottomSheet(
            context: context,  
            isDismissible: true,          
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(4.r)),
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
          tileColor: Theme.of(context).cardColor,
          leading: _ItemLeading(icon: icon, color: color),
          title: CustomText(text: title, size: 14.sp, type: Type.overMedium),
          contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
          subtitle: CustomText(
            text: subtitle,
            size: 12.sp,
            opacity: FontOpacity.medium,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.r),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16.sp,
            color: Theme.of(context).primaryColor,
          ),
        ),
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

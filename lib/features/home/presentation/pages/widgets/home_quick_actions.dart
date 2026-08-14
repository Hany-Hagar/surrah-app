import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:surrah/core/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeQuickActions extends StatelessWidget {
  const HomeQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "الاجراءات السريعة",
          size: 18.sp,
          type: Type.overMedium,
        ),
        SizedBox(height: 10.h),
        Row(
          spacing: 5.w,
          children: [
            _Item(
              color: Colors.green,
              title: "إضافة دخل",
              icon: IconBroken.Wallet,
              onPressed: () {},
            ),
            _Item(
              color: Colors.red,
              title: "إضافة مصروف",
              icon: IconBroken.Send,
              onPressed: () {},
            ),
            _Item(
              color: Colors.orange,
              title: "إضافة تصنيف",
              icon: IconBroken.Category,
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}

class _Item extends StatelessWidget {
  final Color color;
  final String title;
  final IconData icon;
  final VoidCallback onPressed;
  const _Item({
    required this.color,
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: color.withAlpha(50),
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(color: color.withAlpha(50), width: 1.w),
        ),
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 17.r,
              backgroundColor: color,
              child: Icon(icon, color: Colors.white, size: 20.sp),
            ),
            SizedBox(height: 6.h),
            CustomText(text: title, size: 14.sp, type: Type.overMedium),
          ],
        ),
      ),
    );
  }
}

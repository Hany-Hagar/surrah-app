import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogService {
  static Future<T?> showCustomDialog<T>({
    required BuildContext context,
    EdgeInsetsGeometry? padding,
    required Widget body,
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) => Dialog(
        insetPadding:  EdgeInsets.symmetric(horizontal: 12.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        child: Padding(
          padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: body,
        ),
      ),
    );
  }
}

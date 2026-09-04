import 'custom_text.dart';
import '../../const/assets.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FailureView extends StatelessWidget {
  final String? message;
  final String? lottiePath;
  const FailureView({super.key, this.message, this.lottiePath});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(
          lottiePath ?? Assets.failureList,
          width: MediaQuery.of(context).size.width,
        ),
        Transform.translate(
          offset: Offset(0, -30.h),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: CustomText(
              size: 18.sp,
              maxLines: 6,
              type: Type.overMedium,
              textAlign: TextAlign.center,
              text: message ?? 'حدث خطأ أثناء جلب البيانات',
            ),
          ),
        ),
      ],
    );
  }
}

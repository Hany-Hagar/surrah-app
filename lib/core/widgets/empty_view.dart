import 'custom_text.dart';
import '../../const/assets.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyView extends StatelessWidget {
  final String? message;
  final String? lottiePath;
  const EmptyView({super.key, this.lottiePath, this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(
          lottiePath ?? Assets.emptyList,
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
              text: message ?? 'لا توجد بيانات',
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import '../../model/on_boarding_model.dart';
import '../../../../core/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingCard extends StatelessWidget {
  final OnBoardingModel model;
  const OnBoardingCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: Center(child: _Image(imagePath: model.image)),
          ),
          _Text(model: model),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}

class _Image extends StatelessWidget {
  final String imagePath;
  const _Image({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: SvgPicture.asset(
        imagePath,
        fit: BoxFit.contain,
        excludeFromSemantics: true, // رسمة تزيينية
      ),
    );
  }
}

class _Text extends StatelessWidget {
  final OnBoardingModel model;
  const _Text({required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomText(
          text: model.title,
          size: 24.sp,
          type: Type.header,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10.h),
        CustomText(
          text: model.description,
          size: 16.sp,
          maxLines: 3,
          type: Type.overMedium,
          opacity: FontOpacity.medium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
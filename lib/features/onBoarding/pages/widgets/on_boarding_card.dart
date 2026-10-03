import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import '../../model/on_boarding_model.dart';
import '../../../../core/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingCard extends StatelessWidget {
  final OnBoardingModel model;
  const OnBoardingCard({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          _Image(imagePath: model.image),
          Spacer(),
          _Text(onBoardingModel: model),
          SizedBox(height: 32.h),
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
    var size = MediaQuery.of(context).size;
    return SvgPicture.asset(
      imagePath,
      width: size.width * 0.8,
      height: size.height * 0.4,
    );
  }
}

class _Text extends StatelessWidget {
  final OnBoardingModel onBoardingModel;
  const _Text({required this.onBoardingModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomText(
          text: onBoardingModel.title,
          size: 24.sp,
          type: Type.header,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10.h),
        CustomText(
          text: onBoardingModel.description,
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

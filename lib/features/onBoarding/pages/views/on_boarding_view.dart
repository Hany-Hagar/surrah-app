import 'package:flutter/material.dart';
import '../widgets/on_boarding_body.dart';
import '../../../../core/widgets/custom_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        spacing: 10.h,
        children: [
          Expanded(
            child: OnBoardingBody(),
          ),
          _CustomButton(),
        ],
      ),
    );
  }
}



class _CustomButton extends StatelessWidget {
  const _CustomButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: CustomButton(onPressed: () {}, text: "Next"),
    );
  }
}

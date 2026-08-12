import '../widgets/layout_body.dart';
import '../../../../const/assets.dart';
import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LayoutView extends StatelessWidget {
  const LayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: const _Leading(),
        title: 'Welcome Back',
        subtitle: 'Have a nice day!',
        trailingIcon: IconBroken.Setting,
      ),
      body: const LayoutBody(),
    );
  }
}

class _Leading extends StatelessWidget {
  const _Leading();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45.w,
      height: 50.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.r),
        image: const DecorationImage(
          image: AssetImage(Assets.appLogo),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

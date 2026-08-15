import 'home_card.dart';
import 'home_quick_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12.w,
      children: [
        HomeCard(),
        HomeQuickActions(),
      ],
    );
  }
}

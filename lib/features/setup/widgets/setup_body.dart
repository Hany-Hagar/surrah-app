import 'ui_setup_card.dart';
import 'package:flutter/material.dart';
import '../../../core/widgets/custom_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SetupBody extends StatelessWidget {
  final int currentPage;
  final Function() onPressed;
  const SetupBody({
    super.key,
    required this.currentPage,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 16.h),
      child: Column(
        spacing: 16.h,
        children: [
          _Cards(currentPage: currentPage),
          _Button(currentPage: currentPage, onPressed: onPressed),
        ],
      ),
    );
  }
}

class _Cards extends StatelessWidget {
  final int currentPage;
  const _Cards({required this.currentPage});

  @override
  Widget build(BuildContext context) {
    List<Widget> cards = [
      UiSetupCard(),
      Placeholder(fallbackHeight: 200.h, color: Colors.red),
      Placeholder(fallbackHeight: 200.h, color: Colors.green),
      Placeholder(fallbackHeight: 200.h, color: Colors.blue),
      Placeholder(fallbackHeight: 200.h, color: Colors.yellow),
    ];
    return Expanded(child: cards[currentPage]);
  }
}

class _Button extends StatelessWidget {
  final int currentPage;
  final void Function() onPressed;
  const _Button({required this.currentPage, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: onPressed,
      text: currentPage == 3 ? "Get Started" : "Next",
    );
  }
}

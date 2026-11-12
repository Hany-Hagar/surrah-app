import 'package:flutter/material.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class SetupIndicator extends StatelessWidget {
  final int totalPages;
  final int currentPage;
  final void Function() onFinish;
  const SetupIndicator({
    super.key,
    required this.onFinish,
    required this.totalPages,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var top = mediaQuery.padding.top;
    return Padding(
      padding: EdgeInsets.only(top: top),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _Skip(onFinish: onFinish),
          _Indicator(totalPages: totalPages, currentPage: currentPage),
          _Number(totalPages: totalPages, currentPage: currentPage),
        ],
      ),
    );
  }
}

class _Skip extends StatelessWidget {
  final void Function() onFinish;
  const _Skip({required this.onFinish});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (context) => _SkipDialog(onFinished: onFinish),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: CustomText(text: "Skip", size: 16.sp, type: Type.overMedium),
      ),
    );
  }
}

class _SkipDialog extends StatelessWidget {
  final void Function() onFinished;
  const _SkipDialog({required this.onFinished});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: CustomText(size: 18.sp, type: Type.header, text: "Skip Setup"),
      content: CustomText(
        size: 16.sp,
        maxLines: 5,
        type: Type.overMedium,
        opacity: FontOpacity.overMedium,
        text: "Are you sure you want to skip the setup process?",
      ),
      actions: [_SkipActions(onFinished: onFinished)],
    );
  }
}

class _SkipActions extends StatelessWidget {
  final void Function() onFinished;
  const _SkipActions({required this.onFinished});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12.w,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: CustomButton(
            text: "Cancel",
            enableBorderColor: true,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        Expanded(
          child: CustomButton(text: "Skip", onPressed: onFinished),
        ),
      ],
    );
  }
}

class _Indicator extends StatelessWidget {
  final int totalPages;
  final int currentPage;
  const _Indicator({required this.totalPages, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Expanded(
      child: StepProgressIndicator(
        size: 8.h,
        totalSteps: totalPages,
        currentStep: currentPage + 1,
        roundedEdges: Radius.circular(2.r),
        unselectedColor: theme.dividerColor,
        selectedColor: theme.colorScheme.secondary,
      ),
    );
  }
}

class _Number extends StatelessWidget {
  final int totalPages;
  final int currentPage;
  const _Number({required this.totalPages, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: CustomText(
        size: 16.sp,
        type: Type.header,
        color: Theme.of(context).primaryColor,
        text: "${currentPage + 1}/$totalPages",
      ),
    );
  }
}

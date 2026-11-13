import 'package:flutter/material.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../translations/gen/strings.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class NewSetupIndicator extends StatelessWidget {
  final int totalPages;
  final int currentPage;
  final void Function() onFinish;
  const NewSetupIndicator({
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
          _Number(totalPages: totalPages, currentPage: currentPage),
          _Indicator(totalPages: totalPages, currentPage: currentPage),
          _Skip(onFinish: onFinish),
        ],
      ),
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
        text: "${currentPage + 1}/$totalPages",
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}

class _Skip extends StatelessWidget {
  final void Function() onFinish;
  const _Skip({required this.onFinish});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (context) => _SkipDialog(onFinished: onFinish),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: CustomText(
          size: 16.sp,
          text: t.setup.skip,
          type: Type.overMedium,
          color: theme.colorScheme.secondary,
        ),
      ),
    );
  }
}

class _SkipDialog extends StatelessWidget {
  final void Function() onFinished;
  const _SkipDialog({required this.onFinished});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return AlertDialog(
      title: CustomText(
        size: 18.sp,
        type: Type.header,
        text: t.setup.skipDialog.title,
      ),
      content: CustomText(
        size: 16.sp,
        maxLines: 5,
        type: Type.overMedium,
        opacity: FontOpacity.overMedium,
        text: t.setup.skipDialog.message,
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
    final t = Translations.of(context);
    return Row(
      spacing: 12.w,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: CustomButton(
            text: t.setup.skipDialog.cancel,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        Expanded(
          child: CustomButton(
            text: t.setup.skipDialog.confirm,
            enableBorderColor: true,
            onPressed: () {
              Navigator.of(context).pop();
              onFinished();
            },
          ),
        ),
      ],
    );
  }
}

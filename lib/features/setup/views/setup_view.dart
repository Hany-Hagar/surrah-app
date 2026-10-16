import '../widgets/setup_body.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/nav_to.dart';
import '../../../core/di/server_locator.dart';
import '../../../core/widgets/custom_text.dart';
import '../../layout/pages/views/layout_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../settings/presentation/manager/settings_cubit.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class SetupView extends StatefulWidget {
  const SetupView({super.key});
  @override
  State<SetupView> createState() => _SetupViewState();
}

class _SetupViewState extends State<SetupView> {
  int currentPage = 0;
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _Top(totalPages: 3, currentPage: currentPage),
          Expanded(
            child: SetupBody(
              currentPage: currentPage,
              onPressed: () {
                setState(() {
                  if (currentPage == 2) {
                    getIt<SettingsCubit>().setFirstTime(false);
                    NavTo.pushReplacement(
                      context: context,
                      nextPage: const LayoutView(),
                    );
                  } else {
                    currentPage++;
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Top extends StatelessWidget {
  final int totalPages;
  final int currentPage;
  const _Top({required this.totalPages, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Padding(
      padding: EdgeInsetsDirectional.only(
        top: mediaQuery.padding.top,
        end: 12.w,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _Close(),
          Expanded(
            child: _Indicator(totalPages: totalPages, currentPage: currentPage),
          ),
          SizedBox(width: 12.w),
          _Number(totalPages: totalPages, currentPage: currentPage),
        ],
      ),
    );
  }
}

class _Close extends StatelessWidget {
  const _Close();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        getIt<SettingsCubit>().setFirstTime(false);
        NavTo.pushReplacement(context: context, nextPage: const LayoutView());
      },
      icon: Icon(
        Icons.close,
        size: 24.sp,
        color: Theme.of(context).colorScheme.secondary,
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
    return StepProgressIndicator(
      size: 8.h,
      totalSteps: totalPages,
      currentStep: currentPage + 1,
      roundedEdges: Radius.circular(2.r),
      unselectedColor: theme.dividerColor,
      selectedColor: theme.colorScheme.secondary,
    );
  }
}

class _Number extends StatelessWidget {
  final int totalPages;
  final int currentPage;
  const _Number({required this.totalPages, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      size: 16.sp,
      type: Type.header,
      color: Theme.of(context).primaryColor,
      text: "${currentPage + 1}/$totalPages",
    );
  }
}

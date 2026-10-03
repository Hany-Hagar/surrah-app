import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';
import '../widgets/on_boarding_body.dart';
import '../../model/on_boarding_model.dart';
import '../../../../core/utils/nav_to.dart';
import '../../../../core/di/server_locator.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../layout/pages/views/layout_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../settings/presentation/manager/settings_cubit.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  int currentPage = 0;
  final PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = onBoardingData(context);

    return Scaffold(
      body: Column(
        children: [
          _Skip(totalPages: pages.length, pageController: pageController),
          Expanded(
            child: OnBoardingBody(
              pageController: pageController,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
            ),
          ),
          _CustomButton(
            controller: pageController,
            currentPage: currentPage,
            totalPages: pages.length,
          ),
        ],
      ),
    );
  }
}

class _Skip extends StatelessWidget {
  final int totalPages;
  final PageController pageController;
  const _Skip({required this.totalPages, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        end: 16.w,
        top: MediaQuery.of(context).padding.top + 10.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              pageController.jumpToPage(totalPages - 1);
            },
            child: CustomText(
              text: "Skip",
              size: 18.sp,
              type: Type.overMedium,
              opacity: FontOpacity.medium,
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomButton extends StatelessWidget {
  final PageController controller;
  final int currentPage;
  final int totalPages;
  const _CustomButton({
    required this.controller,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final bool isLastPage = currentPage == totalPages - 1;
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: CustomButton(
        onPressed: () {
          if (isLastPage) {
            getIt<SettingsCubit>().setFirstTime(false);
            NavTo.pushReplacement(
              context: context,
              nextPage: const LayoutView(),
            );
            // Navigate to Home
          } else {
            controller.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        },
        text: isLastPage ? s.getStarted : s.next,
      ),
    );
  }
}

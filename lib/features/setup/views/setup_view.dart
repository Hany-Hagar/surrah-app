import '../widgets/setup_body.dart';
import 'package:flutter/material.dart';
import '../../home/views/home_view.dart';
import '../../../core/utils/nav_to.dart';
import '../widgets/setup_indicator.dart';
import '../../../const/icon_broken.dart';
import '../../../core/di/server_locator.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../translations/gen/strings.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../settings/presentation/manager/settings_cubit.dart';
import '../../categories/presentation/manager/categories_cubit.dart';

class SetupView extends StatefulWidget {
  const SetupView({super.key});
  @override
  State<SetupView> createState() => _SetupViewState();
}

class _SetupViewState extends State<SetupView> {
  static const int totalPages = 3;
  int currentPage = 0;
  final PageController controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SetupIndicator(
            onFinish: onFinish,
            totalPages: totalPages,
            currentPage: currentPage,
          ),
          Expanded(
            child: SetupBody(
              controller: controller,
              onPageChanged: onPageChanged,
            ),
          ),
          SafeArea(
            top: false,
            child: _Button(
              currentPage: currentPage,
              totalPages: totalPages,
              onBack: onBack,
              onNext: onNext,
            ),
          ),
        ],
      ),
    );
  }

  void onPageChanged(int index) {
    setState(() => currentPage = index);
  }

  void onNext() {
    if (currentPage < totalPages - 1) {
      controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      onFinish();
    }
  }

  void onBack() {
    if (currentPage > 0) {
      controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void onFinish() {
    getIt<CategoriesCubit>().addLocalCategories();
    getIt<SettingsCubit>().setFirstTime(false);
    NavTo.pushReplacement(context: context, nextPage: HomeView());
  }
}

class _Button extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const _Button({
    required this.currentPage,
    required this.totalPages,
    required this.onNext,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final backIcon = isRtl
        ? IconBroken.Arrow___Right_2
        : IconBroken.Arrow___Left_2;

    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        spacing: 10.w,
        children: [
          if (currentPage != 0)
            CustomButton(
              width: 50.w,
              icon: backIcon,
              onPressed: onBack,
              enableBorderColor: true,
            ),
          Expanded(
            child: CustomButton(
              onPressed: onNext,
              text: currentPage == totalPages - 1
                  ? t.setup.getStarted
                  : t.setup.next,
            ),
          ),
        ],
      ),
    );
  }
}

import '../widgets/splash_body.dart';
import 'package:flutter/material.dart';
import '../../../../const/assets.dart';
import '../../../../core/utils/nav_to.dart';
import '../../../../core/di/server_locator.dart';
import '../../../layout/pages/views/layout_view.dart';
import '../../../onBoarding/pages/views/on_boarding_view.dart';
import '../../../settings/presentation/manager/settings_cubit.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      if (getIt<SettingsCubit>().state.isFirstTime) {
        NavTo.pushReplacement(
          context: context,
          nextPage: const OnBoardingView(),
        );
      } else {
        NavTo.pushReplacement(
          context: context,
          nextPage: const LayoutView(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.splashBackground),
            fit: BoxFit.fill,
          ),
        ),
        child: const Center(child: SplashBody()),
      ),
    );
  }
}

import '../widgets/splash_body.dart';
import 'package:flutter/material.dart';
import '../../../../const/assets.dart';
import '../../../../core/di/server_locator.dart';
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
        // Navigate to onboarding screen
      } else {
        // Navigate to home screen
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

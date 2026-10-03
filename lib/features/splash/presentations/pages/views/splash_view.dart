import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../const/assets.dart';
import '../../../../../core/di/server_locator.dart';
import '../../../../../core/utils/nav_to.dart';
import '../../../../layout/pages/views/layout_view.dart';
import '../../../../onBoarding/pages/views/on_boarding_view.dart';
import '../../../../settings/presentation/manager/settings_cubit.dart';
import '../../manger/splash_cubit.dart';
import '../../manger/splash_state.dart';
import '../widgets/splash_body.dart';


class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(
        settingsCubit: getIt<SettingsCubit>(),
      )..startSplash(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashNavigateToOnBoarding) {
            NavTo.pushReplacement(
              context: context,
              nextPage: const OnBoardingView(),
            );
          } else if (state is SplashNavigateToHome) {
            NavTo.pushReplacement(
              context: context,
              nextPage: const LayoutView(),
            );
          }
        },
        child: Scaffold(
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
        ),
      ),
    );
  }
}
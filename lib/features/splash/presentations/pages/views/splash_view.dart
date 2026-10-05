import '../widgets/splash_body.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../../manger/splash_cubit.dart';
import '../../manger/splash_states.dart';
import '../../../../../const/assets.dart';
import '../../../../../core/utils/nav_to.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/di/server_locator.dart';
import '../../../../layout/pages/views/layout_view.dart';
import '../../../../onBoarding/pages/views/on_boarding_view.dart';

class SplashView extends StatelessWidget {
  final bool isFirstTime;
  const SplashView({super.key, required this.isFirstTime});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<SplashCubit>()..authenticate(isFirstTime: isFirstTime),
      child: BlocListener<SplashCubit, SplashStates>(
        listener: (context, state) {
          if (state is FirstTimeCheckComplete && isFirstTime) {
            NavTo.pushReplacement(context: context, nextPage: OnBoardingView());
          }
          if (state is AuthenticationComplete) {
            NavTo.pushReplacement(context: context, nextPage: LayoutView());
          }
          if (state is AuthenticationFailure) {
            // close the app if authentication fails
            SystemNavigator.pop();
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

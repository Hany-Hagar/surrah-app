import '../widgets/splash_body.dart';
import 'package:flutter/material.dart';
import '../../../../const/assets.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

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
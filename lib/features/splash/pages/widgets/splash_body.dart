import '../../../../const/assets.dart';
import 'package:flutter/material.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> with TickerProviderStateMixin {
  late final AnimationController _fadeController;
  late final AnimationController _floatController;

  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );

    _scaleAnimation = Tween<double>(begin: .8, end: 1).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOutBack),
    );

    _floatAnimation = Tween<double>(begin: -8, end: 8).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width * .45;

    return Center(
      child: AnimatedBuilder(
        animation: Listenable.merge([_fadeController, _floatController]),
        builder: (_, _) {
          return Transform.translate(
            offset: Offset(0, _floatAnimation.value),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: Image.asset(Assets.splashLogo, width: size),
              ),
            ),
          );
        },
      ),
    );
  }
}

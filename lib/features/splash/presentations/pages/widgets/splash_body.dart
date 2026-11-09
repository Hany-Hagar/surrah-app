import 'package:flutter/material.dart';
import '../../../../../const/assets.dart';
import '../../../../../core/widgets/custom_text.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> with TickerProviderStateMixin {
  late final AnimationController _intro;
  late final AnimationController _float;
  late final Animation<double> _fade, _scale, _textFade, _floatY;
  bool _started = false;

  @override
  void initState() {
    super.initState();
    _intro = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _float = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    _fade = CurvedAnimation(
      parent: _intro,
      curve: const Interval(0, .6, curve: Curves.easeOut),
    );
    _scale = Tween<double>(begin: .9, end: 1).animate(
      CurvedAnimation(
        parent: _intro,
        curve: const Interval(0, .6, curve: Curves.easeOutCubic),
      ),
    );
    _textFade = CurvedAnimation(
      parent: _intro,
      curve: const Interval(.5, 1, curve: Curves.easeOut),
    );
    _floatY = Tween<double>(
      begin: -4,
      end: 4,
    ).animate(CurvedAnimation(parent: _float, curve: Curves.easeInOut));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;

    // احترام إعداد "تقليل الحركة" في النظام
    if (MediaQuery.disableAnimationsOf(context)) {
      _intro.value = 1;
      return;
    }
    _intro.forward().whenComplete(() {
      if (mounted) _float.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _intro.dispose();
    _float.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;

    final logo = Semantics(
      label: 'Surrah',
      image: true,
      child: Image.asset(Assets.splashLogo, width: w * .40), // كانت .55
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: Listenable.merge([_intro, _float]),
          child: logo,
          builder: (_, child) => Transform.translate(
            offset: Offset(0, _floatY.value),
            child: FadeTransition(
              opacity: _fade,
              child: Transform.scale(scale: _scale.value, child: child),
            ),
          ),
        ),
        const SizedBox(height: 12), // كانت 20
        FadeTransition(
          opacity: _textFade,
          child: const Column(
            children: [
              CustomText(color: Colors.white, text: 'صُرَة', size: 30),
              SizedBox(height: 4),
              CustomText(
                color: Color(0xFFE5B84A),
                size: 16,
                text: 'SURRAH',
                letterSpacing: 7,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

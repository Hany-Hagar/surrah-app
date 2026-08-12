import 'on_boarding_card.dart';
import 'package:flutter/material.dart';
import '../../model/on_boarding_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingBody extends StatelessWidget {
  const OnBoardingBody({super.key});

  @override
  Widget build(BuildContext context) {
    var data = onBoardingData(context);
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return OnBoardingCard(model: data[index]);
            },
          ),
        ),
        _PageIndicator(pageController: PageController()),
      ],
    );
  }
}

class _PageIndicator extends StatelessWidget {
  final PageController pageController;
  const _PageIndicator({required this.pageController});

  @override
  Widget build(BuildContext context) {
    var data = onBoardingData(context);
    final colors = Theme.of(context).colorScheme;
    return SmoothPageIndicator(
      controller: pageController,
      count: data.length,
      effect: ExpandingDotsEffect(
        spacing: 8,
        dotWidth: 8,
        dotHeight: 8,
        expansionFactor: 3,
        radius: 8,
        dotColor: colors.outlineVariant,
        activeDotColor: colors.secondary,
      ),
    );
  }
}

import 'on_boarding_card.dart';
import 'package:flutter/material.dart';
import '../../model/on_boarding_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingBody extends StatelessWidget {
  final PageController pageController;
  final ValueChanged<int>? onPageChanged;
  const OnBoardingBody({
    super.key,
    required this.pageController,
    this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final data = onBoardingData(context);

    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: pageController,
            onPageChanged: onPageChanged,
            itemCount: data.length,
            itemBuilder: (context, index) =>
                OnBoardingCard(model: data[index]),
          ),
        ),
        _PageIndicator(controller: pageController, count: data.length),
        const SizedBox(height: 16),
      ],
    );
  }
}


class _PageIndicator extends StatelessWidget {
  final PageController controller;
  final int count;
  const _PageIndicator({required this.controller, required this.count});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SmoothPageIndicator(
      controller: controller,
      count: count,
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
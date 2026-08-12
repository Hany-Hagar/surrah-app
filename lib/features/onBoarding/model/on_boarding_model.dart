import '../../../const/assets.dart';
import '../../../generated/l10n.dart';
import 'package:flutter/material.dart';

class OnBoardingModel {
  final int id;
  final String image;
  final String title;
  final String description;
  OnBoardingModel({
    required this.id,
    required this.image,
    required this.title,
    required this.description,
  });
}

List<OnBoardingModel> onBoardingData(BuildContext context) {
  var s = S.of(context);
  return [
    OnBoardingModel(
      id: 1,
      image: Assets.onboarding1,
      title: s.onboardingTitle1,
      description: s.onboardingDescription1,
    ),
    OnBoardingModel(
      id: 2,
      image: Assets.onboarding2,
      title: s.onboardingTitle2,
      description: s.onboardingDescription2,
    ),
    OnBoardingModel(
      id: 3,
      image: Assets.onboarding3,
      title: s.onboardingTitle3,
      description: s.onboardingDescription3,
    ),
    OnBoardingModel(
      id: 4,
      image: Assets.onboarding4,
      title: s.onboardingTitle4,
      description: s.onboardingDescription4,
    ),
  ];
}

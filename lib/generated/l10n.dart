// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: 'The English language name',
      args: [],
    );
  }

  /// `Arabic`
  String get arabic {
    return Intl.message(
      'Arabic',
      name: 'arabic',
      desc: 'The Arabic language name',
      args: [],
    );
  }

  /// `United States`
  String get unitedStates {
    return Intl.message(
      'United States',
      name: 'unitedStates',
      desc: 'United States country name',
      args: [],
    );
  }

  /// `Egypt`
  String get egypt {
    return Intl.message(
      'Egypt',
      name: 'egypt',
      desc: 'Egypt country name',
      args: [],
    );
  }

  /// `Follow Every Pound`
  String get onboardingTitle1 {
    return Intl.message(
      'Follow Every Pound',
      name: 'onboardingTitle1',
      desc: 'Onboarding title for the first slide',
      args: [],
    );
  }

  /// `Easily track your income and expenses.`
  String get onboardingDescription1 {
    return Intl.message(
      'Easily track your income and expenses.',
      name: 'onboardingDescription1',
      desc: 'Onboarding description for the first slide',
      args: [],
    );
  }

  /// `Build Better Financial Habits`
  String get onboardingTitle2 {
    return Intl.message(
      'Build Better Financial Habits',
      name: 'onboardingTitle2',
      desc: 'Onboarding title for the second slide',
      args: [],
    );
  }

  /// `Develop financial habits that help you manage your money wisely.`
  String get onboardingDescription2 {
    return Intl.message(
      'Develop financial habits that help you manage your money wisely.',
      name: 'onboardingDescription2',
      desc: 'Onboarding description for the second slide',
      args: [],
    );
  }

  /// `Achieve Your Financial Goals`
  String get onboardingTitle3 {
    return Intl.message(
      'Achieve Your Financial Goals',
      name: 'onboardingTitle3',
      desc: 'Onboarding title for the third slide',
      args: [],
    );
  }

  /// `Save regularly and get closer to achieving your financial goals.`
  String get onboardingDescription3 {
    return Intl.message(
      'Save regularly and get closer to achieving your financial goals.',
      name: 'onboardingDescription3',
      desc: 'Onboarding description for the third slide',
      args: [],
    );
  }

  /// `Full Control Over Your Money`
  String get onboardingTitle4 {
    return Intl.message(
      'Full Control Over Your Money',
      name: 'onboardingTitle4',
      desc: 'Onboarding title for the fourth slide',
      args: [],
    );
  }

  /// `Track your expenses and make financial decisions with confidence.`
  String get onboardingDescription4 {
    return Intl.message(
      'Track your expenses and make financial decisions with confidence.',
      name: 'onboardingDescription4',
      desc: 'Onboarding description for the fourth slide',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: 'Label for the next button',
      args: [],
    );
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message(
      'Get Started',
      name: 'getStarted',
      desc: 'Label for the get started button',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: 'Label for the skip button',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

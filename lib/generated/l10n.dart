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

  /// `Welcome to Surrah`
  String get layoutAppBarTitle {
    return Intl.message(
      'Welcome to Surrah',
      name: 'layoutAppBarTitle',
      desc: 'Title for the app bar in the layout view',
      args: [],
    );
  }

  /// `Your Personal Finance Companion`
  String get layoutAppBarSubtitle {
    return Intl.message(
      'Your Personal Finance Companion',
      name: 'layoutAppBarSubtitle',
      desc: 'Subtitle for the app bar in the layout view',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: 'Label for the home button',
      args: [],
    );
  }

  /// `Transactions`
  String get transactions {
    return Intl.message(
      'Transactions',
      name: 'transactions',
      desc: 'Label for the transactions button',
      args: [],
    );
  }

  /// `Settings`
  String get settingsTitle {
    return Intl.message(
      'Settings',
      name: 'settingsTitle',
      desc: 'Title for the settings page',
      args: [],
    );
  }

  /// `Manage your preferences`
  String get settingsSubtitle {
    return Intl.message(
      'Manage your preferences',
      name: 'settingsSubtitle',
      desc: 'Subtitle for the settings page',
      args: [],
    );
  }

  /// `⚙️ General`
  String get generalSettings {
    return Intl.message(
      '⚙️ General',
      name: 'generalSettings',
      desc: 'Title for the general settings section',
      args: [],
    );
  }

  /// `Theme`
  String get settingsThemeTitle {
    return Intl.message(
      'Theme',
      name: 'settingsThemeTitle',
      desc: 'Title for the theme settings section',
      args: [],
    );
  }

  /// `Customize the look and feel`
  String get settingsThemeSubtitle {
    return Intl.message(
      'Customize the look and feel',
      name: 'settingsThemeSubtitle',
      desc: 'Subtitle for the theme settings section',
      args: [],
    );
  }

  /// `Language`
  String get settingsLanguageTitle {
    return Intl.message(
      'Language',
      name: 'settingsLanguageTitle',
      desc: 'Title for the language settings section',
      args: [],
    );
  }

  /// `Change the app language`
  String get settingsLanguageSubtitle {
    return Intl.message(
      'Change the app language',
      name: 'settingsLanguageSubtitle',
      desc: 'Subtitle for the language settings section',
      args: [],
    );
  }

  /// `Notifications`
  String get settingsNotificationsTitle {
    return Intl.message(
      'Notifications',
      name: 'settingsNotificationsTitle',
      desc: 'Title for the notifications settings section',
      args: [],
    );
  }

  /// `Manage your notification preferences`
  String get settingsNotificationsSubtitle {
    return Intl.message(
      'Manage your notification preferences',
      name: 'settingsNotificationsSubtitle',
      desc: 'Subtitle for the notifications settings section',
      args: [],
    );
  }

  /// `🔒 Privacy & Support`
  String get settingsPrivacySupportTitle {
    return Intl.message(
      '🔒 Privacy & Support',
      name: 'settingsPrivacySupportTitle',
      desc: 'Title for the privacy and support settings section',
      args: [],
    );
  }

  /// ` Privacy Policy`
  String get settingsPrivacyTitle {
    return Intl.message(
      ' Privacy Policy',
      name: 'settingsPrivacyTitle',
      desc: 'Title for the privacy policy settings section',
      args: [],
    );
  }

  /// `Read our privacy policy`
  String get settingsPrivacySubtitle {
    return Intl.message(
      'Read our privacy policy',
      name: 'settingsPrivacySubtitle',
      desc: 'Subtitle for the privacy policy settings section',
      args: [],
    );
  }

  /// `Contact Support`
  String get settingsSupportTitle {
    return Intl.message(
      'Contact Support',
      name: 'settingsSupportTitle',
      desc: 'Title for the contact support settings section',
      args: [],
    );
  }

  /// `Get help and support`
  String get settingsSupportSubtitle {
    return Intl.message(
      'Get help and support',
      name: 'settingsSupportSubtitle',
      desc: 'Subtitle for the contact support settings section',
      args: [],
    );
  }

  /// `Themes`
  String get themes {
    return Intl.message(
      'Themes',
      name: 'themes',
      desc: 'Label for the themes section',
      args: [],
    );
  }

  /// `Light`
  String get lightTheme {
    return Intl.message(
      'Light',
      name: 'lightTheme',
      desc: 'Label for the light theme option',
      args: [],
    );
  }

  /// `Dark`
  String get darkTheme {
    return Intl.message(
      'Dark',
      name: 'darkTheme',
      desc: 'Label for the dark theme option',
      args: [],
    );
  }

  /// `System`
  String get systemTheme {
    return Intl.message(
      'System',
      name: 'systemTheme',
      desc: 'Label for the system theme option',
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

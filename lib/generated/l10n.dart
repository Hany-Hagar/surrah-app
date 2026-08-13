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

  /// `Theme`
  String get themeTitle {
    return Intl.message(
      'Theme',
      name: 'themeTitle',
      desc: 'Title for the theme settings section',
      args: [],
    );
  }

  /// `Customize the look and feel`
  String get themeSubtitle {
    return Intl.message(
      'Customize the look and feel',
      name: 'themeSubtitle',
      desc: 'Subtitle for the theme settings section',
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

  /// `Language`
  String get languageTitle {
    return Intl.message(
      'Language',
      name: 'languageTitle',
      desc: 'Title for the language settings section',
      args: [],
    );
  }

  /// `Change the app language`
  String get languageSubtitle {
    return Intl.message(
      'Change the app language',
      name: 'languageSubtitle',
      desc: 'Subtitle for the language settings section',
      args: [],
    );
  }

  /// `Current Language :`
  String get currentLanguage {
    return Intl.message(
      'Current Language :',
      name: 'currentLanguage',
      desc: 'Label for the current language setting',
      args: [],
    );
  }

  /// `Other Languages :`
  String get otherLanguages {
    return Intl.message(
      'Other Languages :',
      name: 'otherLanguages',
      desc: 'Label for the other languages setting',
      args: [],
    );
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

  /// `Privacy Policy`
  String get privacyTitle {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyTitle',
      desc: 'Title for the privacy policy settings section',
      args: [],
    );
  }

  /// `Read our privacy policy`
  String get privacySubtitle {
    return Intl.message(
      'Read our privacy policy',
      name: 'privacySubtitle',
      desc: 'Subtitle for the privacy policy settings section',
      args: [],
    );
  }

  /// `Your Privacy Matters`
  String get privacyPolicyCardTitle {
    return Intl.message(
      'Your Privacy Matters',
      name: 'privacyPolicyCardTitle',
      desc: 'Title for the privacy policy card',
      args: [],
    );
  }

  /// `We respect your privacy and are committed to protecting your data.`
  String get privacyPolicyCardDescription {
    return Intl.message(
      'We respect your privacy and are committed to protecting your data.',
      name: 'privacyPolicyCardDescription',
      desc: 'Description for the privacy policy card',
      args: [],
    );
  }

  /// `Data We Collect`
  String get privacyPolicyCard1Title {
    return Intl.message(
      'Data We Collect',
      name: 'privacyPolicyCard1Title',
      desc: 'Title for the first privacy policy card',
      args: [],
    );
  }

  /// `We do not collect personal data. Your expenses and categories are stored locally on your device.`
  String get privacyPolicyCard1Description {
    return Intl.message(
      'We do not collect personal data. Your expenses and categories are stored locally on your device.',
      name: 'privacyPolicyCard1Description',
      desc: 'Description for the first privacy policy card',
      args: [],
    );
  }

  /// `Data Storage`
  String get privacyPolicyCard2Title {
    return Intl.message(
      'Data Storage',
      name: 'privacyPolicyCard2Title',
      desc: 'Title for the second privacy policy card',
      args: [],
    );
  }

  /// `Your data is stored only on your device and is not sent to any external server.`
  String get privacyPolicyCard2Description {
    return Intl.message(
      'Your data is stored only on your device and is not sent to any external server.',
      name: 'privacyPolicyCard2Description',
      desc: 'Description for the second privacy policy card',
      args: [],
    );
  }

  /// `Data Sharing`
  String get privacyPolicyCard3Title {
    return Intl.message(
      'Data Sharing',
      name: 'privacyPolicyCard3Title',
      desc: 'Title for the third privacy policy card',
      args: [],
    );
  }

  /// `We do not share your data with third parties or external services.`
  String get privacyPolicyCard3Description {
    return Intl.message(
      'We do not share your data with third parties or external services.',
      name: 'privacyPolicyCard3Description',
      desc: 'Description for the third privacy policy card',
      args: [],
    );
  }

  /// `Data Security`
  String get privacyPolicyCard4Title {
    return Intl.message(
      'Data Security',
      name: 'privacyPolicyCard4Title',
      desc: 'Title for the fourth privacy policy card',
      args: [],
    );
  }

  /// `Your data is stored locally on your device and protected by the app.`
  String get privacyPolicyCard4Description {
    return Intl.message(
      'Your data is stored locally on your device and protected by the app.',
      name: 'privacyPolicyCard4Description',
      desc: 'Description for the fourth privacy policy card',
      args: [],
    );
  }

  /// `Data Deletion`
  String get privacyPolicyCard5Title {
    return Intl.message(
      'Data Deletion',
      name: 'privacyPolicyCard5Title',
      desc: 'Title for the fifth privacy policy card',
      args: [],
    );
  }

  /// `You can delete your expenses and categories at any time from the app.`
  String get privacyPolicyCard5Description {
    return Intl.message(
      'You can delete your expenses and categories at any time from the app.',
      name: 'privacyPolicyCard5Description',
      desc: 'Description for the fifth privacy policy card',
      args: [],
    );
  }

  /// `Privacy Policy Updates`
  String get privacyPolicyCard6Title {
    return Intl.message(
      'Privacy Policy Updates',
      name: 'privacyPolicyCard6Title',
      desc: 'Title for the sixth privacy policy card',
      args: [],
    );
  }

  /// `We may update this policy from time to time. Important changes will be shown in the app.`
  String get privacyPolicyCard6Description {
    return Intl.message(
      'We may update this policy from time to time. Important changes will be shown in the app.',
      name: 'privacyPolicyCard6Description',
      desc: 'Description for the sixth privacy policy card',
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

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

  /// `Now`
  String get now {
    return Intl.message(
      'Now',
      name: 'now',
      desc: 'Label for the current time',
      args: [],
    );
  }

  /// `Yesterday`
  String get yesterday {
    return Intl.message(
      'Yesterday',
      name: 'yesterday',
      desc: 'Label for the previous day',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: 'Label for the cancel button',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: 'Label for the all categories type',
      args: [],
    );
  }

  /// `Income`
  String get income {
    return Intl.message(
      'Income',
      name: 'income',
      desc: 'Label for the income section',
      args: [],
    );
  }

  /// `Expense`
  String get expense {
    return Intl.message(
      'Expense',
      name: 'expense',
      desc: 'Label for the expenses section',
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

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: 'Label for the home button',
      args: [],
    );
  }

  /// `Welcome to Surrah`
  String get homeTitle {
    return Intl.message(
      'Welcome to Surrah',
      name: 'homeTitle',
      desc: 'Title for the home button',
      args: [],
    );
  }

  /// `Your Personal Finance Companion`
  String get homeSubtitle {
    return Intl.message(
      'Your Personal Finance Companion',
      name: 'homeSubtitle',
      desc: 'Subtitle for the home button',
      args: [],
    );
  }

  /// `Current Balance`
  String get currentBalance {
    return Intl.message(
      'Current Balance',
      name: 'currentBalance',
      desc: 'Label for the current balance section',
      args: [],
    );
  }

  /// `Quick Actions`
  String get quickActions {
    return Intl.message(
      'Quick Actions',
      name: 'quickActions',
      desc: 'Label for the quick actions section',
      args: [],
    );
  }

  /// `Add Income`
  String get addIncome {
    return Intl.message(
      'Add Income',
      name: 'addIncome',
      desc: 'Label for the add income button',
      args: [],
    );
  }

  /// `Add Expense`
  String get addExpense {
    return Intl.message(
      'Add Expense',
      name: 'addExpense',
      desc: 'Label for the add expense button',
      args: [],
    );
  }

  /// `Add Category`
  String get addCategory {
    return Intl.message(
      'Add Category',
      name: 'addCategory',
      desc: 'Label for the add category button',
      args: [],
    );
  }

  /// `Last Transactions`
  String get lastTransactions {
    return Intl.message(
      'Last Transactions',
      name: 'lastTransactions',
      desc: 'Label for the last transactions section',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: 'Label for the categories button',
      args: [],
    );
  }

  /// `Manage Your Categories`
  String get categoriesTitle {
    return Intl.message(
      'Manage Your Categories',
      name: 'categoriesTitle',
      desc: 'Title for the categories page',
      args: [],
    );
  }

  /// `Add, edit, and delete your expense categories`
  String get categoriesSubtitle {
    return Intl.message(
      'Add, edit, and delete your expense categories',
      name: 'categoriesSubtitle',
      desc: 'Subtitle for the categories page',
      args: [],
    );
  }

  /// `Search Categories`
  String get searchCategoriesHint {
    return Intl.message(
      'Search Categories',
      name: 'searchCategoriesHint',
      desc: 'Hint text for the categories search field',
      args: [],
    );
  }

  /// `No categories available`
  String get emptyCategories {
    return Intl.message(
      'No categories available',
      name: 'emptyCategories',
      desc: 'Text for the empty state of categories',
      args: [],
    );
  }

  /// `Type`
  String get categoryType {
    return Intl.message(
      'Type',
      name: 'categoryType',
      desc: 'Label for the category type selection',
      args: [],
    );
  }

  /// `Filter`
  String get filterButton {
    return Intl.message(
      'Filter',
      name: 'filterButton',
      desc: 'Label for the filter button',
      args: [],
    );
  }

  /// `Clear Filter`
  String get clearFilterButton {
    return Intl.message(
      'Clear Filter',
      name: 'clearFilterButton',
      desc: 'Label for the clear filter button',
      args: [],
    );
  }

  /// `Add New Category`
  String get addCategoryDialogTitle {
    return Intl.message(
      'Add New Category',
      name: 'addCategoryDialogTitle',
      desc: 'Title for the add new category dialog',
      args: [],
    );
  }

  /// `Please enter the name of the new category and select its type (Income or Expense).`
  String get addCategoryDialogDescription {
    return Intl.message(
      'Please enter the name of the new category and select its type (Income or Expense).',
      name: 'addCategoryDialogDescription',
      desc: 'Description for the add new category dialog',
      args: [],
    );
  }

  /// `Category Name`
  String get categoryName {
    return Intl.message(
      'Category Name',
      name: 'categoryName',
      desc: 'Hint text for the category name input field',
      args: [],
    );
  }

  /// `e.g., Food, Transportation, Salary`
  String get categoryNameHint {
    return Intl.message(
      'e.g., Food, Transportation, Salary',
      name: 'categoryNameHint',
      desc: 'Hint text for the category name input field',
      args: [],
    );
  }

  /// `Icon Data`
  String get categoryIconData {
    return Intl.message(
      'Icon Data',
      name: 'categoryIconData',
      desc: 'Label for the category icon data input field',
      args: [],
    );
  }

  /// `Tap to select an icon data`
  String get categoryIconDataHint {
    return Intl.message(
      'Tap to select an icon data',
      name: 'categoryIconDataHint',
      desc: 'Hint text for the category icon data input field',
      args: [],
    );
  }

  /// `Color`
  String get color {
    return Intl.message(
      'Color',
      name: 'color',
      desc: 'Label for the color selection',
      args: [],
    );
  }

  /// `New category added successfully`
  String get addNewCategorySuccess {
    return Intl.message(
      'New category added successfully',
      name: 'addNewCategorySuccess',
      desc: 'Message displayed when a new category is added successfully',
      args: [],
    );
  }

  /// `Update Category`
  String get updateCategoryDialogTitle {
    return Intl.message(
      'Update Category',
      name: 'updateCategoryDialogTitle',
      desc: 'Title for the update category dialog',
      args: [],
    );
  }

  /// `Please update the name of the category and select its type (Income or Expense).`
  String get updateCategoryDialogDescription {
    return Intl.message(
      'Please update the name of the category and select its type (Income or Expense).',
      name: 'updateCategoryDialogDescription',
      desc: 'Description for the update category dialog',
      args: [],
    );
  }

  /// `Update Category`
  String get updateCategoryButton {
    return Intl.message(
      'Update Category',
      name: 'updateCategoryButton',
      desc: 'Label for the update category button',
      args: [],
    );
  }

  /// `Category updated successfully`
  String get updateCategorySuccess {
    return Intl.message(
      'Category updated successfully',
      name: 'updateCategorySuccess',
      desc: 'Message displayed when a category is updated successfully',
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

  /// `Manage Your Transactions`
  String get transactionsTitle {
    return Intl.message(
      'Manage Your Transactions',
      name: 'transactionsTitle',
      desc: 'Title for the transactions page',
      args: [],
    );
  }

  /// `Add, edit, and delete your transactions`
  String get transactionsSubtitle {
    return Intl.message(
      'Add, edit, and delete your transactions',
      name: 'transactionsSubtitle',
      desc: 'Subtitle for the transactions page',
      args: [],
    );
  }

  /// `Add Transaction`
  String get addTransactionTitle {
    return Intl.message(
      'Add Transaction',
      name: 'addTransactionTitle',
      desc: 'Title for the add transaction page',
      args: [],
    );
  }

  /// `Add a new transaction to your account`
  String get addTransactionSubtitle {
    return Intl.message(
      'Add a new transaction to your account',
      name: 'addTransactionSubtitle',
      desc: 'Subtitle for the add transaction page',
      args: [],
    );
  }

  /// `Amount`
  String get addTransactionAmountTitle {
    return Intl.message(
      'Amount',
      name: 'addTransactionAmountTitle',
      desc: 'Label for the amount input field',
      args: [],
    );
  }

  /// `Enter Amount :`
  String get addTransactionAmountTypeHint {
    return Intl.message(
      'Enter Amount :',
      name: 'addTransactionAmountTypeHint',
      desc: 'Hint text for the amount input field',
      args: [],
    );
  }

  /// `Category`
  String get addTransactionCategoryTitle {
    return Intl.message(
      'Category',
      name: 'addTransactionCategoryTitle',
      desc: 'Label for the category selection',
      args: [],
    );
  }

  /// `Date`
  String get addTransactionDate {
    return Intl.message(
      'Date',
      name: 'addTransactionDate',
      desc: 'Label for the date selection',
      args: [],
    );
  }

  /// `Notes`
  String get addTransactionNotes {
    return Intl.message(
      'Notes',
      name: 'addTransactionNotes',
      desc: 'Label for the notes input field',
      args: [],
    );
  }

  /// `Add a brief description or note for this transaction`
  String get addTransactionNotesHint {
    return Intl.message(
      'Add a brief description or note for this transaction',
      name: 'addTransactionNotesHint',
      desc: 'Hint text for the notes input field',
      args: [],
    );
  }

  /// `Add Transaction`
  String get addTransactionButton {
    return Intl.message(
      'Add Transaction',
      name: 'addTransactionButton',
      desc: 'Label for the add transaction button',
      args: [],
    );
  }

  /// `Transaction added successfully`
  String get addTransactionSuccess {
    return Intl.message(
      'Transaction added successfully',
      name: 'addTransactionSuccess',
      desc: 'Message displayed when a transaction is added successfully',
      args: [],
    );
  }

  /// `Failed to add transaction`
  String get addTransactionFailure {
    return Intl.message(
      'Failed to add transaction',
      name: 'addTransactionFailure',
      desc: 'Message displayed when a transaction fails to be added',
      args: [],
    );
  }

  /// `Update Transaction`
  String get updateTransactionTitle {
    return Intl.message(
      'Update Transaction',
      name: 'updateTransactionTitle',
      desc: 'Title for the update transaction page',
      args: [],
    );
  }

  /// `Update the details of this transaction`
  String get updateTransactionSubtitle {
    return Intl.message(
      'Update the details of this transaction',
      name: 'updateTransactionSubtitle',
      desc: 'Subtitle for the update transaction page',
      args: [],
    );
  }

  /// `Update Transaction`
  String get updateTransactionButton {
    return Intl.message(
      'Update Transaction',
      name: 'updateTransactionButton',
      desc: 'Label for the update transaction button',
      args: [],
    );
  }

  /// `Transaction updated successfully`
  String get updateTransactionSuccess {
    return Intl.message(
      'Transaction updated successfully',
      name: 'updateTransactionSuccess',
      desc: 'Message displayed when a transaction is updated successfully',
      args: [],
    );
  }

  /// `Failed to update transaction`
  String get updateTransactionFailure {
    return Intl.message(
      'Failed to update transaction',
      name: 'updateTransactionFailure',
      desc: 'Message displayed when a transaction fails to be updated',
      args: [],
    );
  }

  /// `View Detailed Report`
  String get viewReport {
    return Intl.message(
      'View Detailed Report',
      name: 'viewReport',
      desc: 'Label for the view report button',
      args: [],
    );
  }

  /// `Reports`
  String get reportTitle {
    return Intl.message(
      'Reports',
      name: 'reportTitle',
      desc: 'Title for the reports page',
      args: [],
    );
  }

  /// `View your financial reports and insights`
  String get reportSubtitle {
    return Intl.message(
      'View your financial reports and insights',
      name: 'reportSubtitle',
      desc: 'Subtitle for the reports page',
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

  /// `Contact Support`
  String get contactSupportTitle {
    return Intl.message(
      'Contact Support',
      name: 'contactSupportTitle',
      desc: 'Title for the contact support settings section',
      args: [],
    );
  }

  /// `Get help and support`
  String get contactSupportSubtitle {
    return Intl.message(
      'Get help and support',
      name: 'contactSupportSubtitle',
      desc: 'Subtitle for the contact support settings section',
      args: [],
    );
  }

  /// `How can we help you?`
  String get contactSupportHeaderTitle {
    return Intl.message(
      'How can we help you?',
      name: 'contactSupportHeaderTitle',
      desc: 'Title for the contact support header card',
      args: [],
    );
  }

  /// `Find answers to common questions or contact our support team.`
  String get contactSupportHeaderDescription {
    return Intl.message(
      'Find answers to common questions or contact our support team.',
      name: 'contactSupportHeaderDescription',
      desc: 'Description for the contact support header card',
      args: [],
    );
  }

  /// `Email Support`
  String get contactSupportEmailTitle {
    return Intl.message(
      'Email Support',
      name: 'contactSupportEmailTitle',
      desc: 'Title for email support option',
      args: [],
    );
  }

  /// `Reach out by email and we'll be happy to help.`
  String get contactSupportEmailSubtitle {
    return Intl.message(
      'Reach out by email and we\'ll be happy to help.',
      name: 'contactSupportEmailSubtitle',
      desc: 'Subtitle for email support option',
      args: [],
    );
  }

  /// `Phone Support`
  String get contactSupportPhoneTitle {
    return Intl.message(
      'Phone Support',
      name: 'contactSupportPhoneTitle',
      desc: 'Title for phone support option',
      args: [],
    );
  }

  /// `Call our support line for immediate assistance.`
  String get contactSupportPhoneSubtitle {
    return Intl.message(
      'Call our support line for immediate assistance.',
      name: 'contactSupportPhoneSubtitle',
      desc: 'Subtitle for phone support option',
      args: [],
    );
  }

  /// `WhatsApp Support`
  String get contactSupportWhatsAppTitle {
    return Intl.message(
      'WhatsApp Support',
      name: 'contactSupportWhatsAppTitle',
      desc: 'Title for WhatsApp support option',
      args: [],
    );
  }

  /// `Chat with us on WhatsApp for quick support.`
  String get contactSupportWhatsAppSubtitle {
    return Intl.message(
      'Chat with us on WhatsApp for quick support.',
      name: 'contactSupportWhatsAppSubtitle',
      desc: 'Subtitle for WhatsApp support option',
      args: [],
    );
  }

  /// `Frequently Asked Questions`
  String get contactSupportFaqTitle {
    return Intl.message(
      'Frequently Asked Questions',
      name: 'contactSupportFaqTitle',
      desc: 'Title for the frequently asked questions section',
      args: [],
    );
  }

  /// `Where is my data stored?`
  String get contactSupportFaq1Question {
    return Intl.message(
      'Where is my data stored?',
      name: 'contactSupportFaq1Question',
      desc: 'First frequently asked question',
      args: [],
    );
  }

  /// `Your expenses and categories are stored locally on your device.`
  String get contactSupportFaq1Answer {
    return Intl.message(
      'Your expenses and categories are stored locally on your device.',
      name: 'contactSupportFaq1Answer',
      desc: 'Answer to the first frequently asked question',
      args: [],
    );
  }

  /// `Can I delete my data?`
  String get contactSupportFaq2Question {
    return Intl.message(
      'Can I delete my data?',
      name: 'contactSupportFaq2Question',
      desc: 'Second frequently asked question',
      args: [],
    );
  }

  /// `Yes, you can delete your expenses and categories from the app at any time.`
  String get contactSupportFaq2Answer {
    return Intl.message(
      'Yes, you can delete your expenses and categories from the app at any time.',
      name: 'contactSupportFaq2Answer',
      desc: 'Answer to the second frequently asked question',
      args: [],
    );
  }

  /// `Does the app collect my personal data?`
  String get contactSupportFaq3Question {
    return Intl.message(
      'Does the app collect my personal data?',
      name: 'contactSupportFaq3Question',
      desc: 'Third frequently asked question',
      args: [],
    );
  }

  /// `No. The current version does not collect or send your personal data.`
  String get contactSupportFaq3Answer {
    return Intl.message(
      'No. The current version does not collect or send your personal data.',
      name: 'contactSupportFaq3Answer',
      desc: 'Answer to the third frequently asked question',
      args: [],
    );
  }

  /// `Can I add or edit categories?`
  String get contactSupportFaq4Question {
    return Intl.message(
      'Can I add or edit categories?',
      name: 'contactSupportFaq4Question',
      desc: 'Fourth frequently asked question',
      args: [],
    );
  }

  /// `Yes, you can create, edit, and delete your expense categories.`
  String get contactSupportFaq4Answer {
    return Intl.message(
      'Yes, you can create, edit, and delete your expense categories.',
      name: 'contactSupportFaq4Answer',
      desc: 'Answer to the fourth frequently asked question',
      args: [],
    );
  }

  /// `How can we help you?`
  String get contactSupportFooterTitle {
    return Intl.message(
      'How can we help you?',
      name: 'contactSupportFooterTitle',
      desc: 'Title for the contact support footer card',
      args: [],
    );
  }

  /// `We're available 24/7 to help with your questions and support needs.`
  String get contactSupportFooterDescription {
    return Intl.message(
      'We\'re available 24/7 to help with your questions and support needs.',
      name: 'contactSupportFooterDescription',
      desc: 'Description for the contact support footer card',
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

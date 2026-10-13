import 'package:flutter/material.dart';
import 'package:no_screenshot/overlay_mode.dart';
import 'package:world_countries/world_countries.dart';

class AppUserPref {
  final String lang;
  final ThemeMode theme;
  final bool isFirstTime;
  final bool appLockEnabled;
  final FiatCurrency currency;
  final bool appLockSupported;
  final bool notificationsEnabled;
  final OverlayMode screenShotProtection;

  AppUserPref({
    required this.lang,
    required this.theme,
    required this.currency,
    required this.isFirstTime,
    required this.appLockEnabled,
    required this.appLockSupported,
    required this.screenShotProtection,
    required this.notificationsEnabled,
  });

  factory AppUserPref.standard() {
    return AppUserPref(
      lang: 'en',
      isFirstTime: true,
      appLockEnabled: false,
      theme: ThemeMode.light,
      appLockSupported: true,
      notificationsEnabled: true,
      currency: FiatCurrency.egp(),
      screenShotProtection: OverlayMode.none,
    );
  }

  AppUserPref copyWith({
    String? lang,
    ThemeMode? theme,
    bool? isFirstTime,
    bool? appLockEnabled,
    bool? appLockSupported,
    FiatCurrency? currency,
    bool? notificationsEnabled,
    OverlayMode? screenShotProtection,
  }) {
    return AppUserPref(
      lang: lang ?? this.lang,
      theme: theme ?? this.theme,
      currency: currency ?? this.currency,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      appLockEnabled: appLockEnabled ?? this.appLockEnabled,
      appLockSupported: appLockSupported ?? this.appLockSupported,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      screenShotProtection: screenShotProtection ?? this.screenShotProtection,
    );
  }

  factory AppUserPref.fromJson(Map<String, dynamic> json) {
    final themeIndex = json['theme'] as int?;
    final secureIndex = json['secureMode'] as int?;
    final currencyCode = json['currency'] as String? ?? 'EGP';

    return AppUserPref(
      lang: json['lang'] as String? ?? 'en',
      currency: FiatCurrency.fromCode(currencyCode),
      isFirstTime: json['isFirstTime'] as bool? ?? true,
      appLockEnabled: json['appLockEnabled'] as bool? ?? false,
      appLockSupported: json['appLockSupported'] as bool? ?? true,
      notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
      theme: (themeIndex != null &&
              themeIndex >= 0 &&
              themeIndex < ThemeMode.values.length)
          ? ThemeMode.values[themeIndex]
          : ThemeMode.light,
      screenShotProtection: (secureIndex != null &&
              secureIndex >= 0 &&
              secureIndex < OverlayMode.values.length)
          ? OverlayMode.values[secureIndex]
          : OverlayMode.none,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lang': lang,
      'theme': theme.index,
      'currency': currency.code,
      'isFirstTime': isFirstTime,
      'appLockEnabled': appLockEnabled,
      'appLockSupported': appLockSupported,
      'secureMode': screenShotProtection.index,
      'notificationsEnabled': notificationsEnabled,
    };
  }
}
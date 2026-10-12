import 'package:flutter/material.dart';
import 'package:no_screenshot/overlay_mode.dart';

class AppUserPref {
  final String lang;
  final ThemeMode theme;
  final bool isFirstTime;
  final bool appLockEnabled;
  final bool appLockSupported;
  final OverlayMode screenShotProtection;
  final bool notificationsEnabled;
  AppUserPref({
    required this.lang,
    required this.theme,
    required this.screenShotProtection,
    required this.isFirstTime,
    required this.appLockEnabled,
    required this.appLockSupported,
    required this.notificationsEnabled,
  });

  factory AppUserPref.standard() {
    return AppUserPref(
      lang: "en",
      isFirstTime: true,
      appLockEnabled: false,
      theme: ThemeMode.light,
      appLockSupported: true,
      notificationsEnabled: true,
      screenShotProtection: OverlayMode.none,
    );
  }

  AppUserPref copyWith({
    bool? isrtl,
    String? lang,
    ThemeMode? theme,
    bool? isFirstTime,
    bool? appLockEnabled,
    bool? appLockSupported,
    OverlayMode? secureMode,
    bool? notificationsEnabled,
  }) {
    return AppUserPref(
      lang: lang ?? this.lang,
      theme: theme ?? this.theme,
      screenShotProtection: secureMode ?? this.screenShotProtection,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      appLockEnabled: appLockEnabled ?? this.appLockEnabled,
      appLockSupported: appLockSupported ?? this.appLockSupported,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }

  factory AppUserPref.fromJson(Map<String, dynamic> json) {
    return AppUserPref(
      lang: json['lang'] as String? ?? "en",
      theme: ThemeMode.values[json['theme'] as int],
      isFirstTime: json['isFirstTime'] as bool? ?? true,
      appLockEnabled: json['appLockEnabled'] as bool? ?? false,
      screenShotProtection: OverlayMode.values[json['secureMode'] as int],
      appLockSupported: json['appLockSupported'] as bool? ?? true,
      notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lang': lang,
      'theme': theme.index,
      'isFirstTime': isFirstTime,
      'secureMode': screenShotProtection.index,
      'appLockEnabled': appLockEnabled,
      'appLockSupported': appLockSupported,
      'notificationsEnabled': notificationsEnabled,
    };
  }
}

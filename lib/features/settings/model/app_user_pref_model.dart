import 'package:flutter/material.dart';

class AppUserPref {
  final String lang;
  final ThemeMode theme;
  final bool isFirstTime;
  final bool appLockEnabled;
  final bool notificationsEnabled;
  AppUserPref({
    required this.lang,
    required this.theme,
    required this.isFirstTime,
    required this.appLockEnabled,
    required this.notificationsEnabled,
  });

  factory AppUserPref.standard() {
    return AppUserPref(
      lang: "en",
      isFirstTime: true,
      appLockEnabled: false,
      theme: ThemeMode.light,
      notificationsEnabled: true,
    );
  }

  AppUserPref copyWith({
    bool? isrtl,
    String? lang,
    ThemeMode? theme,
    bool? isFirstTime,
    bool? appLockEnabled,
    bool? notificationsEnabled,
  }) {
    return AppUserPref(
      lang: lang ?? this.lang,
      theme: theme ?? this.theme,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      appLockEnabled: appLockEnabled ?? this.appLockEnabled,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }

  factory AppUserPref.fromJson(Map<String, dynamic> json) {
    return AppUserPref(
      lang: json['lang'] as String? ?? "en",
      theme: ThemeMode.values[json['theme'] as int],
      isFirstTime: json['isFirstTime'] as bool? ?? true,
      appLockEnabled: json['appLockEnabled'] as bool? ?? false,
      notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lang': lang,
      'theme': theme.index,
      'isFirstTime': isFirstTime,
      'appLockEnabled': appLockEnabled,
      'notificationsEnabled': notificationsEnabled,
    };
  }
}

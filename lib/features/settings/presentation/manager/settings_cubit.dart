import 'package:flutter/material.dart';
import '../../model/app_user_pref_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:no_screenshot/overlay_mode.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:world_countries/world_countries.dart';

class SettingsCubit extends HydratedCubit<AppUserPref> {
  SettingsCubit() : super(AppUserPref.standard());
  static SettingsCubit get(BuildContext context) => BlocProvider.of(context);

  void changeLanguage(String lang) {
    emit(state.copyWith(lang: lang));
  }

  void changeTheme(ThemeMode theme) {
    emit(state.copyWith(theme: theme));
  }

  void setFirstTime(bool isFirstTime) {
    emit(state.copyWith(isFirstTime: isFirstTime));
  }

  void setCurrency(FiatCurrency currency) {
    emit(state.copyWith(currency: currency));
  }

  void toggleNotifications() {
    final enabled = !state.notificationsEnabled;
    emit(state.copyWith(notificationsEnabled: enabled));
  }

  void toggleAppLock() {
    final enabled = !state.appLockEnabled;
    emit(state.copyWith(appLockEnabled: enabled));
  }

  void setAppLockSupported(bool supported) {
    emit(state.copyWith(appLockSupported: supported));
  }

  void toggleScreenShotProtectionMode() {
    final newMode = state.screenShotProtection == OverlayMode.secure
        ? OverlayMode.none
        : OverlayMode.secure;
    emit(state.copyWith(screenShotProtection: newMode));
  }

  @override
  AppUserPref? fromJson(Map<String, dynamic> json) {
    return AppUserPref.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AppUserPref state) {
    return state.toJson();
  }
}

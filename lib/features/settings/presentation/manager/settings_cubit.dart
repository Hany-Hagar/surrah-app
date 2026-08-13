import 'package:flutter/material.dart';
import '../../model/app_user_pref_model.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class SettingsCubit extends HydratedCubit<AppUserPref> {
  SettingsCubit() : super(AppUserPref.standard());

  void changeLanguage(String lang) {
    emit(state.copyWith(lang: lang));
  }

  void changeTheme(ThemeMode theme) {
    emit(state.copyWith(theme: theme));
  }

  void setFirstTime(bool isFirstTime) {
    emit(state.copyWith(isFirstTime: isFirstTime));
  }

  void toggleNotifications() {
    final enabled = !state.notificationsEnabled;
    emit(state.copyWith(notificationsEnabled: enabled));
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

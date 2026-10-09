import 'splash_states.dart';
import 'package:flutter/material.dart';
import '../../data/repo/splash_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../settings/presentation/manager/settings_cubit.dart';

class SplashCubit extends Cubit<SplashStates> {
  final SplashRepo splashRepo;
  final SettingsCubit settingsCubit;
  SplashCubit({required this.splashRepo, required this.settingsCubit})
    : super(SplashInitial());
  static SplashCubit get(BuildContext context) => BlocProvider.of(context);

  void authenticate({required bool isFirstTime}) async {
    await Future.delayed(const Duration(seconds: 1));
    if (isFirstTime) {
      emit(FirstTimeCheckComplete());
      return;
    }
    if (!settingsCubit.state.appLockEnabled) {
      emit(AuthenticationComplete());
      return;
    }
    emit(AuthenticationLoading());
    final result = await splashRepo.authenticate();
    result.fold((failure) => emit(AuthenticationFailure()), (success) {
      emit(AuthenticationComplete());
      splashRepo.checkForUpdate();
    });
  }
}

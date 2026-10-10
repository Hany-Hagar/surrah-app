import 'splash_states.dart';
import 'package:flutter/material.dart';
import '../../data/repo/splash_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../settings/presentation/manager/settings_cubit.dart';
import '../../../categories/presentation/manager/categories_cubit.dart';

class SplashCubit extends Cubit<SplashStates> {
  final SplashRepo splashRepo;
  final SettingsCubit settingsCubit;
  final CategoriesCubit categoriesCubit;
  SplashCubit({
    required this.splashRepo,
    required this.settingsCubit,
    required this.categoriesCubit,
  }) : super(SplashInitial());
  static SplashCubit get(BuildContext context) => BlocProvider.of(context);

  void _checkDeviceSupport() async {
    final result = await splashRepo.isDeviceSupported();
    result.fold(
      (failure) {
        settingsCubit.setAppLockSupported(false);
      },
      (isSupported) {
        settingsCubit.setAppLockSupported(isSupported);
      },
    );
  }

  void authenticate({required bool isFirstTime}) async {
    await Future.delayed(const Duration(seconds: 1));
    if (isFirstTime) {
      _checkDeviceSupport();
      categoriesCubit.addLocalCategories();
      emit(FirstTimeCheckComplete());
      return;
    }
    if (!settingsCubit.state.appLockEnabled ||
        !settingsCubit.state.appLockSupported) {
      emit(AuthenticationSuccess());
      return;
    }
    emit(AuthenticationLoading());
    final result = await splashRepo.authenticate();
    result.fold((failure) => emit(AuthenticationFailure()), (success) {
      emit(AuthenticationSuccess());
      splashRepo.checkForUpdate();
    });
  }
}

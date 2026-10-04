import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/app_lock_service.dart';
import '../../../settings/presentation/manager/settings_cubit.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit({required this.settingsCubit}) : super(SplashInitial());

  final SettingsCubit settingsCubit;

  Future<void> startSplash() async {
    await Future.delayed(const Duration(seconds: 1));
    await AppLockService.instance.onSplashFinished();

    if (settingsCubit.state.isFirstTime) {
      emit(SplashNavigateToOnBoarding());
    } else {
      emit(SplashNavigateToHome());
    }
  }
}
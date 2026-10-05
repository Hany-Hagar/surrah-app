import 'dart:developer';
import 'splash_states.dart';
import 'package:flutter/material.dart';
import '../../data/repo/splash_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<SplashStates> {
  final SplashRepo splashRepo;
  SplashCubit({required this.splashRepo}) : super(SplashInitial());
  static SplashCubit get(BuildContext context) => BlocProvider.of(context);

  void authenticate({required bool isFirstTime}) async {
    await Future.delayed(const Duration(seconds: 1));
    if (isFirstTime) {
      log('****** First time user detected. Navigating to onboarding. ******');
      emit(FirstTimeCheckComplete());
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

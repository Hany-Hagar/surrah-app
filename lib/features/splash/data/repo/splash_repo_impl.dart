import 'splash_repo.dart';
import 'package:dartz/dartz.dart';
import '../database/splash_data.dart';
import '../../../../core/errors/failure.dart';

class SplashRepoImpl extends SplashRepo {
  final SplashData splashData;
  SplashRepoImpl({required this.splashData});

  @override
  Future<Either<Failure, bool>> authenticate() async {
    try {
      var isSupported = await splashData.isDeviceSupported();
      var hasBiometrics = await splashData.hasLocalAuth();
      if (!isSupported || !hasBiometrics) {
        return Left(LocalAuthFailure(message: "Device does not support"));
      }
      var result = await splashData.authenticate();
      return Right(result);
    } catch (e) {
      return Left(LocalAuthFailure(message: e.toString()));
    }
  }
}

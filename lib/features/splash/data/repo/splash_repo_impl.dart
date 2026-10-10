import 'splash_repo.dart';
import 'package:dartz/dartz.dart';
import '../database/splash_data.dart';
import '../../../../core/errors/failure.dart';

class SplashRepoImpl extends SplashRepo {
  final SplashData splashData;
  SplashRepoImpl({required this.splashData});

  @override
  Future<Either<Failure, bool>> isDeviceSupported() async {
    try {
      var result = await splashData.isDeviceSupported();
      return Right(result);
    } catch (e) {
      return Left(LocalAuthFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> authenticate() async {
    try {
      var result = await splashData.authenticate();
      return Right(result);
    } catch (e) {
      return Left(LocalAuthFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> checkForUpdate() async {
    try {
      await splashData.checkForUpdate();
      return const Right(null);
    } catch (e) {
      return Left(UpdateFailure(message: e.toString()));
    }
  }
}

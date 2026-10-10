import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';

abstract class SplashRepo {
  Future<Either<Failure, bool>> isDeviceSupported();
  Future<Either<Failure, bool>> authenticate();
  Future<Either<Failure, void>> checkForUpdate();
}

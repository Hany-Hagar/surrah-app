import '../../../../core/services/local_auth_service.dart';

class SplashData {
  final LocalAuthService localAuth;
  SplashData({required this.localAuth});

  // Check if the device supports biometric authentication
  Future<bool> isDeviceSupported() async {
    return await localAuth.isDeviceSupported();
  }

  // Check if the device has enrolled biometrics
  Future<bool> hasLocalAuth() async {
    return await localAuth.hasEnrolledBiometrics();
  }

  // Authenticate the user using biometrics
  Future<bool> authenticate() async {
    return await localAuth.authenticate();
  }
}

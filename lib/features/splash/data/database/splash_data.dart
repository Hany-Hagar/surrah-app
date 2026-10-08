import '../../../../core/services/local_auth_service.dart';
import '../../../../core/services/update_service.dart';

class SplashData {
  final LocalAuthService localAuth;
  final UpdateService updateService;
  SplashData({required this.localAuth, required this.updateService});

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

  // Check for app updates
  Future<void> checkForUpdate() async {
    await updateService.checkForUpdate();
  }
}

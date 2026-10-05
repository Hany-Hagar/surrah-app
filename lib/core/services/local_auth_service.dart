import 'package:local_auth/local_auth.dart';

class LocalAuthService {
  final LocalAuthentication localAuth;
  LocalAuthService({required this.localAuth});

  // Check if the device supports biometric authentication
  Future<bool> isDeviceSupported() async {
    try {
      return await localAuth.isDeviceSupported();
    } catch (e) {
      return false;
    }
  }

  // Check if the device has enrolled biometrics
  Future<bool> hasEnrolledBiometrics() async {
    try {
      return await localAuth.canCheckBiometrics;
    } catch (e) {
      return false;
    }
  }

  // Authenticate the user using biometrics
  Future<bool> authenticate() async {
    try {
      return localAuth.authenticate(
        localizedReason: "Authenticate to access the app",
      );
    } catch (e) {
      return false;
    }
  }
}

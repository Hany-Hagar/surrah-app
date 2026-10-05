import 'package:in_app_update/in_app_update.dart';

class UpdateService {
  const UpdateService();

  Future<void> checkForUpdate() async {
    try {
      final updateInfo = await InAppUpdate.checkForUpdate();

      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        await InAppUpdate.startFlexibleUpdate();
      }
    } catch (_) {
      // Ignore errors
    }
  }
}

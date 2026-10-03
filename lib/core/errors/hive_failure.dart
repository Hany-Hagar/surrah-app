import 'package:hive/hive.dart';
import 'failure.dart';

class HiveFailure extends Failure {
  const HiveFailure(super.message);

  factory HiveFailure.fromError(Object error) {
    if (error is HiveError) {
      final message = error.message.toLowerCase();

      if (message.contains('already open')) {
        return HiveFailure.boxAlreadyOpen();
      }

      if (message.contains('not open')) {
        return HiveFailure.boxNotOpen();
      }

      if (message.contains('box') && message.contains('not found')) {
        return HiveFailure.boxNotFound();
      }

      if (message.contains('open')) {
        return HiveFailure.failedToOpenBox();
      }

      if (message.contains('read')) {
        return HiveFailure.failedToReadData();
      }

      if (message.contains('write')) {
        return HiveFailure.failedToWriteData();
      }

      if (message.contains('delete')) {
        return HiveFailure.failedToDeleteData();
      }

      if (message.contains('clear')) {
        return HiveFailure.failedToClearBox();
      }

      if (message.contains('close')) {
        return HiveFailure.failedToCloseHive();
      }

      if (message.contains('initialize')) {
        return HiveFailure.initializationFailed();
      }
    }

    return HiveFailure.unknown(error);
  }

  factory HiveFailure.boxNotFound() {
    return const HiveFailure('The requested box was not found.');
  }

  factory HiveFailure.boxAlreadyOpen() {
    return const HiveFailure('The box is already open.');
  }

  factory HiveFailure.boxNotOpen() {
    return const HiveFailure('The box is not open.');
  }

  factory HiveFailure.failedToOpenBox() {
    return const HiveFailure('Failed to open the box.');
  }

  factory HiveFailure.failedToReadData() {
    return const HiveFailure('Failed to read data.');
  }

  factory HiveFailure.failedToWriteData() {
    return const HiveFailure('Failed to write data.');
  }

  factory HiveFailure.failedToDeleteData() {
    return const HiveFailure('Failed to delete data.');
  }

  factory HiveFailure.failedToClearBox() {
    return const HiveFailure('Failed to clear the box.');
  }

  factory HiveFailure.failedToCloseHive() {
    return const HiveFailure('Failed to close Hive.');
  }

  factory HiveFailure.initializationFailed() {
    return const HiveFailure('Failed to initialize Hive.');
  }

  factory HiveFailure.unknown(Object error) {
    return HiveFailure(error.toString());
  }
}
import 'package:flutter/widgets.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLockService with WidgetsBindingObserver {
  AppLockService._();
  static final instance = AppLockService._();

  static const _key = 'app_lock_enabled';
  static const lockDelay = Duration.zero;

  final _auth = LocalAuthentication();
  final ValueNotifier<bool> locked = ValueNotifier(false);

  bool _splashDone = false, _authenticating = false;
  DateTime? _pausedAt;

  void init() => WidgetsBinding.instance.addObserver(this);

  Future<bool> isEnabled() async =>
      (await SharedPreferences.getInstance()).getBool(_key) ?? false;

  Future<void> setEnabled(bool v) async {
    await (await SharedPreferences.getInstance()).setBool(_key, v);
    debugPrint('AppLock -> setEnabled($v)');
  }

  Future<bool> isDeviceSecure() async {
    try {
      return await _auth.isDeviceSupported();
    } catch (e) {
      debugPrint('AppLock isDeviceSecure error: $e');
      return false;
    }
  }

  Future<bool> shouldLock() async {
    final enabled = await isEnabled();
    final secure = await isDeviceSecure();
    debugPrint('AppLock -> enabled=$enabled secure=$secure');
    return enabled && secure;
  }

  Future<bool> authenticate() async {
    try {
      final ok = await _auth.authenticate(
        localizedReason: 'Authenticate to open Surrah',
        biometricOnly: false,
        persistAcrossBackgrounding: true,
      );
      debugPrint('AppLock -> authenticate result=$ok');
      return ok;
    } catch (e) {
      debugPrint('AppLock authenticate error: $e');
      return false;
    }
  }

  Future<void> onSplashFinished() async {
    debugPrint('AppLock -> splash finished');
    _splashDone = true;
    await _lockIfNeeded();
  }

  Future<void> _lockIfNeeded() async {
    if (!await shouldLock()) return;
    debugPrint('AppLock -> locking now');
    locked.value = true;
    unlock();
  }

  Future<void> unlock() async {
    if (_authenticating) return;
    _authenticating = true;
    final ok = await authenticate();
    _authenticating = false;
    if (ok) locked.value = false;
  }

 @override
void didChangeAppLifecycleState(AppLifecycleState state) {
  if (!_splashDone) return;
  if (state == AppLifecycleState.paused) {
    if (!_authenticating && !locked.value) _pausedAt = DateTime.now();
  } else if (state == AppLifecycleState.resumed) {
    if (locked.value) {
      unlock();
      return;
    }
    final at = _pausedAt;
    _pausedAt = null;
    if (_authenticating || at == null) return;
    if (DateTime.now().difference(at) >= lockDelay) _lockIfNeeded();
  }
}
}
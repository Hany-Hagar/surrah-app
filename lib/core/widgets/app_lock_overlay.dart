import 'package:flutter/material.dart';
import '../services/app_lock_service.dart';

class AppLockOverlay extends StatelessWidget {
  const AppLockOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: AppLockService.instance.unlock,
        child: ColoredBox(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}
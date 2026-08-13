import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'snack_bar_service.dart';

class SupportService {
  SupportService._();

  static const String supportEmail = 'support@example.com';
  static const String supportPhone = '+201000000000';
  static const String whatsappNumber = '201000000000';

  /// 📧 Open email client
  static Future<void> email({required BuildContext context}) async {
    final Uri uri = Uri(
      scheme: 'mailto',
      path: supportEmail,
      queryParameters: {'subject': 'Support Request'},
    );
    await _launch(
      context: context,
      uri: uri,
      errorMessage: 'No email app found on your device.',
    );
  }

  /// 📞 Open phone dialer
  static Future<void> call({required BuildContext context}) async {
    final Uri uri = Uri(scheme: 'tel', path: supportPhone);

    await _launch(
      context: context,
      uri: uri,
      errorMessage: 'Unable to open the phone app.',
    );
  }

  /// 💬 Open WhatsApp
  static Future<void> whatsapp({required BuildContext context}) async {
    final Uri uri = Uri.parse('https://wa.me/$whatsappNumber');

    await _launch(
      context: context,
      uri: uri,
      errorMessage: 'WhatsApp is not available on your device.',
    );
  }

  static Future<void> _launch({
    required BuildContext context,
    required Uri uri,
    required String errorMessage,
  }) async {
    try {
      final bool canLaunch = await canLaunchUrl(uri);

      if (!canLaunch) {
        if (context.mounted) {
          SnackBarService.failure(context: context, message: errorMessage);
        }
        return;
      }
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      if (context.mounted) {
        SnackBarService.failure(context: context, message: errorMessage);
      }
    }
  }
}

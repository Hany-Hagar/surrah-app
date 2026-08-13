import 'package:url_launcher/url_launcher.dart';

class SupportService {
  // Phone number for support
  static const String supportPhoneNumber = '+1234567890';

  // Email address for support
  static const String supportEmailAddress = 'support@example.com';

  // WhatsApp number for support
  static const String supportWhatsAppNumber = '+1234567890';

  // Method to initiate a phone call
  static Future<void> callSupport() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: supportPhoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch $phoneUri';
    }
  }

  // Method to send an email
  static Future<void> emailSupport() async {
    final Uri emailUri = Uri(scheme: 'mailto', path: supportEmailAddress);
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not launch $emailUri';
    }
  }

  // Method to open WhatsApp
  static Future<void> openWhatsApp() async {
    final Uri whatsAppUri = Uri(
      scheme: 'https',
      host: 'wa.me',
      path: supportWhatsAppNumber,
    );
    if (await canLaunchUrl(whatsAppUri)) {
      await launchUrl(whatsAppUri);
    } else {
      throw 'Could not launch $whatsAppUri';
    }
  }
}

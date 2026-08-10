import '../../generated/l10n.dart';
import 'package:flutter/material.dart';

extension LanguageCodeExtension on String {
  String get toLanguageFlag {
    switch (toLowerCase()) {
      case 'en':
        return "US";
      case 'ar':
        return "EG";
      default:
        return '🏳️';
    }
  }

  String toCuntryName(BuildContext context) {
    switch (toLowerCase()) {
      case 'en':
        return S.of(context).unitedStates;
      case 'ar':
        return S.of(context).egypt;
      default:
        return this;
    }
  }

  String toLanguageName(BuildContext context) {
    switch (toLowerCase()) {
      case 'en':
        return S.of(context).english;
      case 'ar':
        return S.of(context).arabic;
      default:
        return this; // ترجع نفس الكود إذا لم تكن مدعومة
    }
  }
}

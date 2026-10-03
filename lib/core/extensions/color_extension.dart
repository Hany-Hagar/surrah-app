import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

extension ColorExtension on Color {
  String get hexCode {
    return '#${toARGB32().toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';
  }

  String get colorName {
    return ColorTools.nameThatColor(this);
  }
}

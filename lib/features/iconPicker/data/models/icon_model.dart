import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconModel {
  final String id;
  final FaIconData icon;
  final List<String> keywords;
  const IconModel({
    required this.id,
    required this.icon,
    required this.keywords,
  });
}

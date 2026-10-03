import 'package:flutter/widgets.dart';

class IconModel {
  final String id;
  final IconData icon; 
  final List<String> keywords;

  const IconModel({
    required this.id,
    required this.icon,
    required this.keywords,
  });
}
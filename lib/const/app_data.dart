import 'package:flutter/material.dart';

List<BoxShadow> defaultBoxShadow({
  bool isSelected = false,
  Color color = Colors.blue,
}) {
  return [
    BoxShadow(
      color: isSelected ? color.withAlpha(60) : Colors.black.withAlpha(13),
      blurRadius: 16,
      offset: const Offset(0, 6),
    ),
  ];
}

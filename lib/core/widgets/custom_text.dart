import '../utils/styles.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Type? type;
  final double size;
  final Color? color;
  final FontOpacity? opacity;
  final double? height;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final double? letterSpacing;

  const CustomText({
    super.key,
    required this.text,
    required this.size,
    this.color,
    this.type,
    this.opacity,
    this.height,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.letterSpacing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: _style(
        size: size,
        type: type ?? Type.medium,
        height: height,
        letterSpacing: letterSpacing,
        color: color ?? theme.colorScheme.onSurface,
        opacity: opacity ?? FontOpacity.high,
      ),
    );
  }

  TextStyle _style({
    required Type type,
    required double size,
    required Color color,
    required FontOpacity opacity,
    double? height,
    double? letterSpacing,
  }) {
    final baseStyle = switch (type) {
      Type.header => Styles.textStyle800,
      Type.overMedium => Styles.textStyle700,
      Type.medium => Styles.textStyle600,
      Type.overSmall => Styles.textStyle400,
      Type.small => Styles.textStyle100,
    };

    return baseStyle.copyWith(
      fontSize: size,
      height: height,
      letterSpacing: letterSpacing,
      color: _opacityColor(color, opacity),
    );
  }

  Color _opacityColor(Color color, FontOpacity opacity) {
    return switch (opacity) {
      FontOpacity.high => color,
      FontOpacity.medium => color.withValues(alpha: 0.60),
      FontOpacity.overLow => color.withValues(alpha: 0.40),
      FontOpacity.low => color.withValues(alpha: 0.20),
    };
  }
}

enum Type {
  header,
  overMedium,
  medium,
  overSmall,
  small,
}

enum FontOpacity {
  high,
  medium,
  overLow,
  low,
}
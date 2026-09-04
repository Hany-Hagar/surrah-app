import 'custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final bool isLoading;
  final double? width;
  final double? height;
  final String? text;
  final Color? color;
  final IconData? icon;
  final double itemSize;
  final VoidCallback onPressed;
  final double? borderRadius;
  final bool enableBorderColor;
  final EdgeInsetsGeometry? padding;

  const CustomButton({
    super.key,
    this.isLoading = false,
    this.width,
    this.height,
    this.text,
    this.color,
    this.icon,
    this.itemSize = 20,
    required this.onPressed,
    this.borderRadius,
    this.enableBorderColor = false,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width?.w ?? double.infinity,
      height: (height ?? 55).h,
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : _Body(
              text: text,
              color: color,
              icon: icon,
              itemSize: itemSize,
              onPressed: onPressed,
              borderRadius: borderRadius,
              enableBorderColor: enableBorderColor,
              padding: padding,
            ),
    );
  }
}

class _Body extends StatelessWidget {
  final String? text;
  final Color? color;
  final IconData? icon;
  final double itemSize;
  final VoidCallback onPressed;
  final double? borderRadius;
  final bool enableBorderColor;
  final EdgeInsetsGeometry? padding;

  const _Body({
    this.text,
    this.color,
    this.icon,
    required this.itemSize,
    required this.onPressed,
    this.borderRadius,
    this.enableBorderColor = false,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final backgroundColor = enableBorderColor
        ? Colors.transparent
        : color ?? theme.colorScheme.secondary;

    final foregroundColor = enableBorderColor
        ? (color ?? colors.primary)
        : theme.scaffoldBackgroundColor;

    final borderColor = enableBorderColor
        ? (color ?? theme.colorScheme.secondary)
        : Colors.transparent;

    final fontColor = enableBorderColor
        ? (color ?? theme.colorScheme.secondary)
        : theme.scaffoldBackgroundColor;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        padding: padding ?? EdgeInsets.symmetric(horizontal: 0.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 4.r),
          side: BorderSide(
            color: borderColor,
            width: enableBorderColor ? 1.w : 0,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            text: text ?? '',
            size: itemSize.sp,
            type: Type.overMedium,
            color: fontColor,
          ),
          if (icon != null) ...[
            SizedBox(width: 4.w),
            Icon(icon, size: (itemSize + 6).sp, color: fontColor),
          ],
        ],
      ),
    );
  }
}

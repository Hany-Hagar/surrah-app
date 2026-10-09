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
      child: _Body(
        text: text,
        icon: icon,
        color: color,
        padding: padding,
        itemSize: itemSize,
        isLoading: isLoading,
        onPressed: onPressed,
        borderRadius: borderRadius,
        enableBorderColor: enableBorderColor,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final String? text;
  final Color? color;
  final IconData? icon;
  final bool isLoading;
  final double itemSize;
  final double? borderRadius;
  final VoidCallback onPressed;
  final bool enableBorderColor;
  final EdgeInsetsGeometry? padding;

  const _Body({
    this.text,
    this.icon,
    this.color,
    this.padding,
    this.borderRadius,
    required this.itemSize,
    required this.isLoading,
    required this.onPressed,
    this.enableBorderColor = false,
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
      child: isLoading
          ? Padding(
            padding: EdgeInsets.all(5.w),
            child: Center(child: CircularProgressIndicator(color: fontColor))
          )
          : Row(
              spacing: 7.w,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (icon != null)
                  Icon(icon, size: (itemSize + 4).sp, color: fontColor),
                if (text != null)
                  CustomText(
                    text: text!,
                    size: itemSize.sp,
                    type: Type.overMedium,
                    color: fontColor,
                  ),
              ],
            ),
    );
  }
}

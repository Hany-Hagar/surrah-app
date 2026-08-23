import '../utils/styles.dart';
import '../utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  // Value
  final String? initialValue;

  // Controller
  final TextEditingController? controller;
  final TextEditingController? passwordController;

  // Text Settings
  final bool obscureText;
  final TextInputType? keyboardType;
  final int maxLines;
  final int? maxLength;
  final bool readOnly;
  final bool autocorrect;
  final TextInputAction? textInputAction;

  // Auto Lines
  final bool autoMaxLines;
  final int? maxAutoLines;

  // Decoration
  final InputBorder? border;
  final Color? backgroundColor;
  final EdgeInsets? padding;

  // Text Style
  final String? hintText;
  final String? labelText;
  final TextStyle? inputStyle;
  final TextStyle? hintStyle;

  // Icons
  final IconData? prefixIcon;
  final VoidCallback? prefixTap;

  final IconData? suffixIcon;
  final VoidCallback? suffixTap;

  // Events
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final ValueChanged<String?>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldSetter<String>? onSaved;

  // Alignment
  final TextAlign? textAlign;

  // Validation
  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    this.initialValue,
    this.controller,
    this.passwordController,
    this.obscureText = false,
    this.keyboardType,
    this.maxLines = 1,
    this.maxLength,
    this.readOnly = false,
    this.autocorrect = false,
    this.textInputAction,
    this.autoMaxLines = false,
    this.maxAutoLines,
    this.border,
    this.backgroundColor,
    this.padding,
    this.hintText,
    this.labelText,
    this.inputStyle,
    this.hintStyle,
    this.prefixIcon,
    this.prefixTap,
    this.suffixIcon,
    this.suffixTap,
    this.onTap,
    this.focusNode,
    this.onChanged,
    this.onFieldSubmitted,
    this.onSaved,
    this.textAlign,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      // Value
      initialValue: initialValue,

      // Controller
      focusNode: focusNode,
      controller: controller,

      // Events
      onTap: onTap,
      onSaved: onSaved,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,

      // Input Settings
      readOnly: readOnly,
      maxLength: maxLength,
      autocorrect: autocorrect,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,

      // Auto Lines
      maxLines: _getMaxLines(),
      minLines: autoMaxLines ? 1 : null,

      // Alignment
      textAlign: textAlign ?? TextAlign.start,
      textAlignVertical: TextAlignVertical.top,

      // Style
      cursorColor: theme.hintColor,
      style: inputStyle ?? _FontStyle.input(context),

      // Validation
      validator:
          validator ??
          (value) => Validators.validate(
            value: value,
            keyboardType: keyboardType,
            confirmPasswordController: passwordController,
          ),

      decoration: InputDecoration(
        isDense: true,

        // Border
        border: _buildBorder(context),
        enabledBorder: _buildBorder(context),
        focusedBorder: _buildBorder(context, color: theme.primaryColor),

        // Colors
        filled: true,
        fillColor: backgroundColor ?? theme.scaffoldBackgroundColor,

        // Text
        hintText: hintText,
        labelText: labelText,
        hintStyle: hintStyle ?? _FontStyle.hint(context),

        // Icons
        prefixIcon: _buildPrefixIcon(),
        suffixIcon: _buildSuffixIcon(),

        prefixIconConstraints: BoxConstraints(minWidth: 30.w, minHeight: 0),

        // Padding
        contentPadding: _buildContentPadding(),

        errorStyle: Styles.textStyle500.copyWith(
          color: Colors.red,
          fontSize: 14.sp,
        ),
      ),

      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
    );
  }

  // Max Lines Builder
  int? _getMaxLines() {
    if (!autoMaxLines) {
      return maxLines;
    }

    return maxAutoLines;
  }

  // Border Builder
  InputBorder _buildBorder(BuildContext context, {Color? color}) {
    final borderColor =
        color ?? Theme.of(context).hintColor.withValues(alpha: .5);

    return border?.copyWith(
          borderSide: BorderSide(width: 1.2, color: borderColor),
        ) ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
          borderSide: BorderSide(width: 1.2, color: borderColor),
        );
  }

  // Padding Builder
  EdgeInsetsGeometry _buildContentPadding() {
    return padding ??
        EdgeInsetsDirectional.only(
          start: 8.w,
          end: 8.w,
          top: 12.h,
          bottom: 12.h,
        );
  }

  // Prefix Icon Builder
  Widget? _buildPrefixIcon() {
    if (prefixIcon == null) return null;

    return GestureDetector(
      onTap: prefixTap,
      child: Padding(
        padding: EdgeInsetsDirectional.only(start: 16.w, end: 4.w),
        child: Icon(prefixIcon),
      ),
    );
  }

  // Suffix Icon Builder
  Widget? _buildSuffixIcon() {
    if (suffixIcon == null) return null;

    return GestureDetector(onTap: suffixTap, child: Icon(suffixIcon));
  }
}

class _FontStyle {
  // Hint Style
  static TextStyle hint(BuildContext context) {
    return Styles.textStyle800.copyWith(
      color: Theme.of(context).hintColor.withValues(alpha: .5),
      fontSize: 15.sp,
    );
  }

  // Input Style
  static TextStyle input(BuildContext context) {
    return Styles.textStyle800.copyWith(
      color: Theme.of(context).hintColor,
      fontSize: 17.sp,
    );
  }
}

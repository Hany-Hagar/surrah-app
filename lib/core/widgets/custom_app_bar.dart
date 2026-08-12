import 'custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final double padding;
  final Widget? leading;
  final String? subtitle;
  final Gradient? gradient;
  final IconData? trailingIcon;
  final Color? backgroundColor;
  final Function()? onTrailingPressed;
  const CustomAppBar({
    super.key,
    this.leading,
    this.subtitle,
    this.gradient,
    this.trailingIcon,
    this.padding = 12,
    this.title,
    this.backgroundColor,
    this.onTrailingPressed,
  });

  @override
  Widget build(BuildContext context) {
    double padding = this.padding.w;
    var topPadding = MediaQuery.of(context).padding.top;
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        color: backgroundColor ?? Theme.of(context).appBarTheme.backgroundColor,
      ),
      child: ListTile(
        leading: leading,
        title: _title(),
        subtitle: _subTitle(),
        trailing: _trailing(),
        horizontalTitleGap: 12.w,
        tileColor: Colors.transparent,
        visualDensity: VisualDensity.standard,
        contentPadding: EdgeInsetsDirectional.only(
          bottom: 0,
          end: padding.w,
          start: padding.w,
          top: topPadding - 9.h,
        ),
      ),
    );
  }

  Widget? _title() {
    if (title == null) return null;
    return CustomText(text: title!, size: 20.sp, type: Type.header);
  }

  Widget? _subTitle() {
    if (subtitle == null) return null;
    return CustomText(
      text: subtitle!,
      size: 16.sp,
      type: Type.overMedium,
      opacity: FontOpacity.medium,
    );
  }

  Widget _trailing() {
    if (trailingIcon == null) return const SizedBox.shrink();
    return GestureDetector(
      onTap: onTrailingPressed,
      child: Icon(trailingIcon, size: 28.sp),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(subtitle == null ? 64.h : 72.h);
}

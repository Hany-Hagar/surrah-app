import 'custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final double padding;
  final Widget? leading;
  final String? subtitle;
  final Gradient? gradient;
  final Widget? bottom;
  final IconData? trailingIcon;
  final Color? backgroundColor;
  final double bottomHeight;
  final Function()? onTrailingPressed;
  final Widget? trailing;
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
    this.bottom,
    this.bottomHeight = 0,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    var topPadding = MediaQuery.of(context).padding.top;
    return Container(
      padding: EdgeInsets.only(
        top: topPadding + padding.h,
        left: padding.w,
        right: padding.w,
        bottom: padding.h,
      ),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(bottom != null ? 12.r : 0.r),
        ),
        color: backgroundColor ?? Theme.of(context).appBarTheme.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        spacing: 12.h,
        children: [
          Row(
            spacing: 10.w,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ?leading,
              Expanded(
                child: _Body(title: title, subtitle: subtitle),
              ),
              ?trailing,
              _Trailing(
                trailingIcon: trailingIcon,
                onTrailingPressed: onTrailingPressed,
              ),
            ],
          ),
          ?bottom,
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
    subtitle == null ? (bottomHeight + 64).h : (bottomHeight + 78).h,
  );
}

class _Body extends StatelessWidget {
  final String? title;
  final String? subtitle;
  const _Body({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _Title(title: title),
        _SubTitle(subtitle: subtitle),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  const _Title({required this.title});

  @override
  Widget build(BuildContext context) {
    return CustomText(text: title ?? "", size: 18.sp, type: Type.header);
  }
}

class _SubTitle extends StatelessWidget {
  final String? subtitle;
  const _SubTitle({required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: subtitle ?? "",
      size: 15.sp,
      type: Type.overMedium,
      opacity: FontOpacity.medium,
    );
  }
}

class _Trailing extends StatelessWidget {
  final IconData? trailingIcon;
  final Function()? onTrailingPressed;
  const _Trailing({
    required this.trailingIcon,
    required this.onTrailingPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (trailingIcon == null) return const SizedBox.shrink();
    return GestureDetector(
      onTap: onTrailingPressed,
      child: Icon(trailingIcon, size: 28.sp),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../../core/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddTransactionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? body;
  final Widget? trailing;
  final double bodySpacing;
  final CrossAxisAlignment itemsAlignment;
  const AddTransactionCard({
    super.key,
    required this.icon,
    required this.title,
    this.body,
    this.trailing,
    this.bodySpacing = 8,
    this.itemsAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(4.r),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: .1),
            blurRadius: 4.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Row(
        spacing: 12.w,
        crossAxisAlignment: itemsAlignment,
        children: [
          _Icon(icon: icon),
          if (trailing == null)
            Expanded(
              child: _Body(title: title, subtitle: body, spacing: bodySpacing),
            ),
          if (trailing != null) _Body(title: title, subtitle: body, spacing: bodySpacing),

          ?trailing,
        ],
      ),
    );
  }
}

class _Icon extends StatelessWidget {
  final IconData icon;
  const _Icon({required this.icon});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: theme.scaffoldBackgroundColor,
        border: Border.all(color: theme.colorScheme.secondary, width: 1.2.w),
      ),
      child: Icon(icon, size: 24.sp, color: theme.colorScheme.secondary),
    );
  }
}

class _Body extends StatelessWidget {
  final String title;
  final Widget? subtitle;
  final double spacing;
  const _Body({required this.title, this.subtitle, required this.spacing});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: spacing.h,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: title, size: 18.sp, type: Type.overMedium),
        ?subtitle,
      ],
    );
  }
}

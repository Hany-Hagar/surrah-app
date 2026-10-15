import '../../../generated/l10n.dart';
import 'package:flutter/material.dart';
import '../../../core/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SetupCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;
  const SetupCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    var theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h),
        CustomText(
          text: s.appName,
          size: 18.sp,
          type: Type.header,
          color: theme.colorScheme.secondary,
        ),
        SizedBox(height: 2.h),
        CustomText(text: title, size: 18.sp, type: Type.header),
        CustomText(
          size: 14.sp,
          text: subtitle,
          type: Type.overMedium,
          opacity: FontOpacity.medium,
        ),
        SizedBox(height: 16.h),
        child,
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../../../generated/l10n.dart';
import '../../../core/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeLastTransactions extends StatelessWidget {
  const HomeLastTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: S.of(context).lastTransactions,
          size: 18.sp,
          type: Type.overMedium,
        ),
        SizedBox(width: double.infinity, height: 10.h),
      ],
    );
  }
}

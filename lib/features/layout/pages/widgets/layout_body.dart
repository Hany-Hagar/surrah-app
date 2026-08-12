import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';
import '../../managers/layout_cubit.dart';
import '../../managers/layout_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LayoutBody extends StatelessWidget {
  const LayoutBody({super.key});

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    return BlocBuilder<LayoutCubit, LayoutStates>(
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);
        return PageView(
          controller: cubit.pageController,
          onPageChanged: (value) => cubit.changeBottomNavBarIndex(value),
          children: [
            CustomText(text: s.home, size: 16.sp, opacity: FontOpacity.high),
            CustomText(
              text: s.transactions,
              size: 16.sp,
              opacity: FontOpacity.high,
            ),
          ],
        );
      },
    );
  }
}

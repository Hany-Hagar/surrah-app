import '../widgets/layout_body.dart';
import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';
import '../../managers/layout_cubit.dart';
import '../../managers/layout_states.dart';
import '../../../../core/utils/styles.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LayoutView extends StatelessWidget {
  const LayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const LayoutBody(),
      bottomNavigationBar: const _BottomNavigatorBar(),
    );
  }
}



class _BottomNavigatorBar extends StatelessWidget {
  const _BottomNavigatorBar();
  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    return BlocBuilder<LayoutCubit, LayoutStates>(
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);
        return BottomNavigationBar(
          selectedFontSize: 12.sp,
          showSelectedLabels: true,
          currentIndex: cubit.currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (value) => cubit.changeBottomNavBarIndex(value),
          selectedLabelStyle: Styles.textStyle800.copyWith(fontSize: 14.sp),
          unselectedLabelStyle: Styles.textStyle700.copyWith(fontSize: 12.sp),
          items: [
            _item(icon: IconBroken.Home, label: s.home),
            _item(icon: IconBroken.Category, label: s.categories),
            _item(icon: IconBroken.Paper, label: s.transactions),
          ],
        );
      },
    );
  }

  BottomNavigationBarItem _item({
    required IconData icon,
    required String label,
  }) {
    return BottomNavigationBarItem(icon: Icon(icon), label: label);
  }
}

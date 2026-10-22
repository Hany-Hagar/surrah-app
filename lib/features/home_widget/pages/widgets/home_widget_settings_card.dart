import 'package:flutter/material.dart';
import '../../../../const/assets.dart';
import '../../../../const/app_data.dart';
import '../../../../generated/l10n.dart';
import 'package:icon_broken/icon_broken.dart';
import '../../manager/home_widget_cubit.dart';
import '../../manager/home_widget_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surrah/core/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/extensions/number_formatting_extension.dart';

class HomeWidgetSettingsCard extends StatelessWidget {
  const HomeWidgetSettingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        spacing: 10.h,
        mainAxisSize: MainAxisSize.min,
        children: [const _Top(), _Body(), _Actions()],
      ),
    );
  }
}

class _Top extends StatelessWidget {
  const _Top();

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    var theme = Theme.of(context);
    return ListTile(
      dense: true,
      leading: _Leading(),
      minTileHeight: 55.h,
      minVerticalPadding: 0,
      horizontalTitleGap: 12.w,
      contentPadding: EdgeInsets.zero,
      title: CustomText(
        size: 18.sp,
        text: s.appName,
        type: Type.overMedium,
        color: theme.scaffoldBackgroundColor,
      ),
      subtitle: CustomText(
        size: 14.sp,
        type: Type.overMedium,
        color: theme.colorScheme.secondary,
        text: "Your Personal Finance Companion",
      ),
    );
  }
}

class _Leading extends StatelessWidget {
  const _Leading();

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).colorScheme.secondary;
    return Container(
      width: 45.w,
      height: 45.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(Assets.appLogo),
        ),
        border: Border.all(color: color, width: 1.w),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        boxShadow: defaultBoxShadow(),
        borderRadius: BorderRadius.circular(6.r),
        color: Theme.of(context).disabledColor.withAlpha(80),
      ),
      child: Row(
        children: const [
          Expanded(child: _CurrentBalance()),
          _SecureIcon(isSecure: true),
        ],
      ),
    );
  }
}

class _CurrentBalance extends StatelessWidget {
  const _CurrentBalance();

  @override
  Widget build(BuildContext context) {
    var color = Colors.white;
    return BlocBuilder<HomeWidgetCubit, HomeWidgetStates>(
      builder: (context, state) {
        var cubit = HomeWidgetCubit.get(context);
        var isSecure = !cubit.showBalanceCard;
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              size: 16.sp,
              color: color,
              type: Type.overMedium,
              text: "Current Balance:",
            ),
            CustomText(
              color: color,
              type: Type.overMedium,
              height: isSecure ? 1.3 : 1.3,
              size: isSecure ? 22.sp : 24.sp,
              text: cubit.currentBalance.homeWidgetFormat(
                context: context,
                showBalance: cubit.showBalanceCard,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SecureIcon extends StatelessWidget {
  final bool isSecure;
  const _SecureIcon({required this.isSecure});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.secondary;
    return Icon(
      isSecure ? IconBroken.Hide : IconBroken.Lock,
      size: 30.sp,
      color: color,
    );
  }
}

class _Actions extends StatelessWidget {
  const _Actions();

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    var cubit = HomeWidgetCubit.get(context);
    return Row(
      spacing: 10.w,
      children: [
        if (cubit.showIncomeButton)
          _Item(
            title: s.addIncome,
            color: Colors.green,
            icon: IconBroken.Wallet,
          ),
        if (cubit.showExpenseButton)
          _Item(title: s.addExpense, color: Colors.red, icon: IconBroken.Send),
        if (cubit.showAddCategoryButton)
          _Item(
            title: s.addCategory,
            color: Colors.orange,
            icon: IconBroken.Category,
          ),
      ],
    );
  }
}

class _Item extends StatelessWidget {
  final Color color;
  final String title;
  final IconData icon;
  const _Item({required this.color, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    var textColor = Theme.of(context).scaffoldBackgroundColor;
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: color.withAlpha(50),
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(color: color.withAlpha(50), width: 1.w),
        ),
        padding: EdgeInsets.symmetric(vertical: 5.h).copyWith(top: 8.h),
        child: Column(
          spacing: 3.h,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              radius: 17.r,
              backgroundColor: color,
              child: Icon(icon, color: textColor, size: 20.sp),
            ),
            CustomText(
              text: title,
              size: 14.sp,
              color: textColor,
              type: Type.overMedium,
            ),
          ],
        ),
      ),
    );
  }
}

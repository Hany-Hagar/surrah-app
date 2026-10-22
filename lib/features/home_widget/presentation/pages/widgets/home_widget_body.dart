import 'package:flutter/material.dart';
import 'home_widget_settings_card.dart';
import '../../manager/home_widget_cubit.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/custom_switch.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeWidgetBody extends StatelessWidget {
  const HomeWidgetBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h),
        HomeWidgetSettingsCard(),
        SizedBox(height: 16.h),
        _EnableHomeWidget(),
        SizedBox(height: 12.h),
        _Body(),
      ],
    );
  }
}

class _EnableHomeWidget extends StatelessWidget {
  const _EnableHomeWidget();

  @override
  Widget build(BuildContext context) {
    var cubit = HomeWidgetCubit.get(context);
    var enabled = cubit.homeWidgetData.enableCard;
    return _Item(
      icon: PhosphorIcons.power(PhosphorIconsStyle.duotone),
      color: const Color(0xFFE5B845),
      isEnabled: enabled,
      title: 'Home Screen Widget',
      onTap: () => cubit.toggleEnableWidget(),
      backgroundColor: const Color(0xFFE5B845).withAlpha(31),
      subtitle: enabled ? 'Widget is active' : 'Widget is turned off',
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    var enabled = HomeWidgetCubit.get(context).homeWidgetData.enableCard;
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: IgnorePointer(
        ignoring: !enabled,
        child: Column(
          spacing: 14.h,
          mainAxisSize: MainAxisSize.min,
          children: [_Display(), _QuickActions()],
        ),
      ),
    );
  }
}

class _Display extends StatelessWidget {
  const _Display();

  @override
  Widget build(BuildContext context) {
    var cubit = HomeWidgetCubit.get(context);
    return _ItemsList(
      title: "Display",
      items: [
        _Item(
          icon: PhosphorIcons.eye(PhosphorIconsStyle.duotone),
          title: 'Show balance',
          subtitle: 'Hidden by default',
          color: const Color(0xFFE5B845),
          onTap: () => cubit.toggleShowBalanceCard(),
          isEnabled: cubit.homeWidgetData.showBalance,
        ),
      ],
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    var cubit = HomeWidgetCubit.get(context);
    var data = cubit.homeWidgetData;
    return _ItemsList(
      title: "Quick Actions",
      items: [
        _Item(
          title: 'Income button',
          subtitle: 'Quick add income',
          color: const Color(0xFF2E9E55),
          isEnabled: data.showIncomeButton,
          onTap: () => cubit.toggleShowIncomeButton(),
          icon: PhosphorIcons.trendUp(PhosphorIconsStyle.duotone),
        ),
        _Item(
          title: 'Expense button',
          subtitle: 'Quick add expense',
          color: const Color(0xFFD8453B),
          isEnabled: data.showExpenseButton,
          onTap: () => cubit.toggleShowExpenseButton(),
          icon: PhosphorIcons.trendDown(PhosphorIconsStyle.duotone),
        ),
        _Item(
          title: 'Category button',
          subtitle: 'Quick add category',
          color: const Color(0xFFFF9800),
          isEnabled: data.showAddCategoryButton,
          onTap: () => cubit.toggleShowAddCategoryButton(),
          icon: PhosphorIcons.squaresFour(PhosphorIconsStyle.duotone),
        ),
      ],
    );
  }
}

class _ItemsList extends StatelessWidget {
  final String title;
  final List<Widget> items;
  const _ItemsList({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          size: 16.sp,
          type: Type.overMedium,
          opacity: FontOpacity.overMedium,
        ),
        Column(spacing: 10.h, children: items),
      ],
    );
  }
}

class _Item extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final bool isEnabled;
  final String subtitle;
  final VoidCallback onTap;
  final Color? backgroundColor;

  const _Item({
    required this.icon,
    required this.color,
    required this.title,
    required this.isEnabled,
    required this.subtitle,
    required this.onTap,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minTileHeight: 60.h,
      horizontalTitleGap: 10.r,
      leading: _Leading(icon: icon, color: color),
      tileColor: backgroundColor ?? Theme.of(context).cardColor,
      contentPadding: EdgeInsetsDirectional.only(start: 16.r, end: 0),
      title: CustomText(text: title, size: 18.sp, type: Type.overMedium),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      subtitle: CustomText(
        text: subtitle,
        size: 14.sp,
        opacity: FontOpacity.medium,
      ),
      trailing: CustomSwitch(value: isEnabled, onChanged: (value) => onTap()),
    );
  }
}

class _Leading extends StatelessWidget {
  final IconData icon;
  final Color color;
  const _Leading({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44.w,
      height: 44.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withAlpha(31),
      ),
      child: Icon(icon, color: color, size: 24.sp),
    );
  }
}

import 'package:flutter/material.dart';
import 'home_widget_settings_card.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/custom_switch.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeWidgetBody extends StatelessWidget {
  const HomeWidgetBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12.r,
      children: [
        HomeWidgetSettingsCard(),
        _Item(
          icon: PhosphorIcons.eye(PhosphorIconsStyle.duotone),
          color: const Color(0xFFE5B845),
          title: 'Show balance',
          subtitle: 'Hidden by default',
          isEnabled: false,
          onTap: () {},
        ),
        _Item(
          icon: PhosphorIcons.trendUp(PhosphorIconsStyle.duotone),
          color: const Color(0xFF2E9E55),
          title: 'Income button',
          subtitle: 'Quick add income',
          isEnabled: true,
          onTap: () {},
        ),
        _Item(
          icon: PhosphorIcons.trendDown(PhosphorIconsStyle.duotone),
          color: const Color(0xFFD8453B),
          title: 'Expense button',
          subtitle: 'Quick add expense',
          isEnabled: true,
          onTap: () {},
        ),
        _Item(
          icon: PhosphorIcons.squaresFour(PhosphorIconsStyle.duotone),
          color: const Color(0xFFFF9800),
          title: 'Category button',
          subtitle: 'Quick add category',
          isEnabled: true,
          onTap: () {},
        ),
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

  const _Item({
    required this.icon,
    required this.color,
    required this.title,
    required this.isEnabled,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minTileHeight: 60.h,
      horizontalTitleGap: 10.r,
      tileColor: Theme.of(context).cardColor,
      leading: _Leading(icon: icon, color: color),
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

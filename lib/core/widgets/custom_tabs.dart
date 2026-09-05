import 'custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTabs<T> extends StatelessWidget {
  final T selectedValue;
  final List<T> tabs;
  final List<Widget> bodies;
  final ValueChanged<T>? onTabChanged;
  final String Function(T value) labelBuilder;

  const CustomTabs({
    super.key,
    required this.selectedValue,
    required this.tabs,
    required this.bodies,
    required this.labelBuilder,
    this.onTabChanged,
  });
  @override
  Widget build(BuildContext context) {
    final selectedIndex = tabs.indexOf(selectedValue);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: List.generate(tabs.length, (index) {
            final value = tabs[index];
            return _Tab(
              title: labelBuilder(value),
              isSelected: value == selectedValue,
              onTap: () => onTabChanged?.call(value),
            );
          }),
        ),
        SizedBox(width: double.infinity, height: 12.h),
        if (selectedIndex != -1) bodies[selectedIndex],
      ],
    );
  }
}

class _Tab extends StatelessWidget {
  final bool isSelected;
  final String title;
  final VoidCallback onTap;

  const _Tab({
    required this.isSelected,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var color = isSelected ? theme.primaryColor.withAlpha(45) : theme.cardColor;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(
            width: 1.5.w,
            color: isSelected ? theme.primaryColor : const Color(0xFFBDBDBD),
          ),
        ),
        child: CustomText(text: title, size: 15.sp, type: Type.header),
      ),
    );
  }
}

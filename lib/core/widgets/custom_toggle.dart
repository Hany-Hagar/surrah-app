import 'custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomToggle<T> extends StatelessWidget {
  final double? width;
  final double? height;
  final List<T> items;
  final T selectedItem;
  final ValueChanged<T> onChanged;
  final String Function(T item) itemLabel;

  const CustomToggle({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
    required this.itemLabel,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width ?? double.infinity,
      child: SegmentedButton<T>(
        segments: items
            .map(
              (item) => ButtonSegment<T>(
                value: item,
                label: CustomText(
                  text: itemLabel(item),
                  size: 17.sp,
                  type: Type.overMedium,
                  color: item == selectedItem ? Theme.of(context).cardColor : null,
                ),
              ),
            )
            .toList(),
        showSelectedIcon: false,
        selected: {selectedItem},
        onSelectionChanged: (selection) {
          onChanged(selection.first);
        },
        style: SegmentedButton.styleFrom(
          shape: RoundedRectangleBorder(
            side: BorderSide.none,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
      ),
    );
  }
}

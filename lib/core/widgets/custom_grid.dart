import 'empty_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomGrid<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final double childAspectRatio;
  final EdgeInsetsGeometry padding;
  final Widget? extraItem;
  final String? emptyMessage;

  const CustomGrid({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.crossAxisCount = 4,
    this.crossAxisSpacing = 5,
    this.mainAxisSpacing = 5,
    this.childAspectRatio = 1,
    this.extraItem,
    this.emptyMessage,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return EmptyView(message: emptyMessage);
    }
    return GridView.builder(
      padding: padding,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length + (extraItem != null ? 1 : 0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: mainAxisSpacing.h,
        crossAxisSpacing: crossAxisSpacing.w,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) {
        if (index == items.length && extraItem != null) {
          return extraItem!;
        }
        return itemBuilder(context, items[index]);
      },
    );
  }
}

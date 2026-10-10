import 'custom_text.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:surrah/const/assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomGrid<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final Widget? extraItem;
  final int crossAxisCount;
  final String? emptyMessage;
  final ScrollPhysics? physics;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;
  final EdgeInsetsGeometry padding;

  const CustomGrid({
    super.key,
    this.physics,
    this.extraItem,
    this.emptyMessage,
    required this.items,
    this.crossAxisCount = 4,
    this.mainAxisSpacing = 8,
    required this.itemBuilder,
    this.crossAxisSpacing = 8,
    this.childAspectRatio = 1,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return _Empty(message: emptyMessage);
    }
    return GridView.builder(
      padding: padding,
      shrinkWrap: true,
      itemCount: items.length + (extraItem != null ? 1 : 0),
      physics: physics ?? const NeverScrollableScrollPhysics(),
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

class _Empty extends StatelessWidget {
  final String? message;
  const _Empty({required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: double.infinity),
        Lottie.asset(
          Assets.emptyList,
          width: MediaQuery.of(context).size.width * 0.8,
        ),
        Transform.translate(
          offset: Offset(0, -20.h),
          child: CustomText(
            size: 18.sp,
            type: Type.header,
            opacity: FontOpacity.medium,
            text: message ?? "No items found",
          ),
        ),
      ],
    );
  }
}

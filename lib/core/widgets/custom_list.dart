
import 'custom_text.dart';
import '../../const/assets.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomList extends StatelessWidget {
  // Loading
  final bool isLoading;
  final List loadingItems;
  // Failure
  final bool isFailure;
  final String? errorMessage;
  final String? errorLottiePath;
  // Empty
  final String? emptyMessage;
  final String? emptyLottiePath;
  // List
  final List items;
  final double itemSperator;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? scrollPhysics;
  final Widget Function(dynamic) itemBuilder;

  const CustomList({
    super.key,
    // Loading
    this.isLoading = false,
    this.loadingItems = const [],
    // Failure
    this.isFailure = false,
    this.errorMessage,
    this.errorLottiePath,
    // Empty
    this.emptyMessage,
    this.emptyLottiePath,
    // List
    required this.items,
    this.itemSperator = 8,
    this.padding,
    this.scrollPhysics,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    if (isFailure) {
      return _Failure(
        errorMessage: errorMessage,
        errorLottiePath: errorLottiePath,
      );
    }
    if (items.isEmpty && !isLoading) {
      return _Empty(
        emptyMessage: emptyMessage,
        emptyLottiePath: emptyLottiePath,
      );
    }
    return Skeletonizer(
      enabled: isLoading,
      child: _List(
        items: isLoading ? loadingItems : items,
        itemSperator: itemSperator,
        padding: padding,
        itemBuilder: itemBuilder,
        scrollPhysics: scrollPhysics,
      ),
    );
  }
}

class _Failure extends StatelessWidget {
  final String? errorMessage;
  final String? errorLottiePath;
  const _Failure({this.errorMessage, this.errorLottiePath});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(
          errorLottiePath ?? Assets.failureList,
          width: MediaQuery.of(context).size.width,
        ),
        Transform.translate(
          offset: Offset(0, -30.h),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: CustomText(
              size: 18.sp,
              maxLines: 6,
              type: Type.overMedium,
              textAlign: TextAlign.center,
              text: errorMessage ?? 'حدث خطأ أثناء جلب البيانات',
            ),
          ),
        ),
      ],
    );
  }
}

class _Empty extends StatelessWidget {
  final String? emptyLottiePath;
  final String? emptyMessage;
  const _Empty({this.emptyLottiePath, this.emptyMessage});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(
          emptyLottiePath ?? Assets.emptyList,
          width: MediaQuery.of(context).size.width,
        ),
        Transform.translate(
          offset: Offset(0, -30.h),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: CustomText(
              size: 18.sp,
              maxLines: 6,
              type: Type.overMedium,
              textAlign: TextAlign.center,
              text: emptyMessage ?? 'لا توجد بيانات',
            ),
          ),
        ),
      ],
    );
  }
}

class _List extends StatelessWidget {
  final List items;
  final double itemSperator;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? scrollPhysics;
  final Widget Function(dynamic) itemBuilder;
  const _List({
    required this.items,
    this.padding,
    this.scrollPhysics,
    this.itemSperator = 8,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: scrollPhysics,
      padding:
          padding ??
          EdgeInsets.only(top: 10.h, bottom: 80.h, left: 12.w, right: 12.w),
      itemCount: items.length,
      itemBuilder: (context, index) => itemBuilder(items[index]),
      separatorBuilder: (context, index) => SizedBox(height: itemSperator.h),
    );
  }
}
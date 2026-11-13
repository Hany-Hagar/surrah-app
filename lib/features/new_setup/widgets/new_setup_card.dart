import 'package:flutter/material.dart';
import '../../../core/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewSetupCard extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget avatar;
  final String subtitle;
  const NewSetupCard({
    super.key,
    required this.title,
    required this.child,
    required this.avatar,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _Background(),
        _Card(title: title, avatar: avatar, subtitle: subtitle),
        DraggableScrollableSheet(
          snap: true,
          minChildSize: 0.65,
          maxChildSize: 0.65,
          initialChildSize: 0.65,
          shouldCloseOnMinExtent: true,
          builder: (context, scrollController) => _Body(child: child),
        ),
      ],
    );
  }
}

class _Background extends StatelessWidget {
  const _Background();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: const SizedBox.expand(),
    );
  }
}

class _Card extends StatelessWidget {
  final String title;
  final Widget avatar;
  final String subtitle;
  const _Card({
    required this.title,
    required this.avatar,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    var top = MediaQuery.of(context).padding.top;
    var color = Theme.of(context).scaffoldBackgroundColor;
    return Padding(
      padding: EdgeInsets.only(top: top + 24.h, left: 16.w, right: 16.w),
      child: Column(
        spacing: 10.h,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: double.infinity, height: 10.h),
          avatar,
          CustomText(text: title, size: 22.sp, type: Type.header, color: color),
          CustomText(
            maxLines: 2,
            size: 15.sp,
            color: color,
            text: subtitle,
            textAlign: TextAlign.center,
            opacity: FontOpacity.overMedium,
          ),
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final Widget child;
  const _Body({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: child,
    );
  }
}

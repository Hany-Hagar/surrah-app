import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final EdgeInsets? padding;
  final PreferredSizeWidget appBar;

  const CustomScaffold({
    super.key,
    this.padding,
    required this.body,
    required this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    final contentPadding =
        padding ?? EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h);

    return Scaffold(
      appBar: appBar,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: contentPadding,
            child: SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: body,
            ),
          );
        },
      ),
    );
  }
}

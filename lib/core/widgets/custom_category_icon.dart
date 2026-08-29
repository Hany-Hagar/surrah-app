import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../features/iconPicker/data/models/icon_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomCategoryIcon extends StatelessWidget {
  final Color color;
  final IconModel icon;
  const CustomCategoryIcon({
    super.key,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.r,
      height: 40.r,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Center(
        child: FaIcon(icon.icon, color: Colors.white, size: 25.r),
      ),
    );
  }
}

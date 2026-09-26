import 'package:flutter/material.dart';
import '../../features/iconPicker/data/models/icon_model.dart';
import '../extensions/icon_extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../features/categories/data/models/category_model.dart';

class CustomCategoryIcon extends StatelessWidget {
  final double size;
  final Color? color;
  final bool isCircle;
  final IconModel? iconData;
  final CategoryModel? category;
  const CustomCategoryIcon({
    super.key,
    this.color,
    this.iconData,
    this.category,
    this.size = 50,
    this.isCircle = true,
  });

  @override
  Widget build(BuildContext context) {
    var icon = iconData?.icon ?? category?.iconId.getIconById()?.icon;
    return Container(
      width: size.r,
      height: size.r,
      decoration: BoxDecoration(
        color: color ?? Color(category!.color),
        shape:isCircle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius:isCircle?null :BorderRadius.circular( 8.r),
      ),
      child: Center(
        child: FaIcon(icon, color: Colors.white, size: (size * 0.5).r),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../extensions/icon_extensions.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../features/iconPicker/data/models/icon_model.dart';
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

  // نسبة ثابتة لحجم الأيقونة داخل الدايرة، عشان كل التصنيفات تبان موحّدة
  static const double _iconRatio = 0.55;

  @override
  Widget build(BuildContext context) {
    final icon = iconData?.icon ?? category?.iconId.getIconById()?.icon;
    final base =
        color ?? (category != null ? Color(category!.color) : Colors.grey);

    // درجة أفتح وأغمق قليلًا من نفس اللون
    final hsl = HSLColor.fromColor(base);
    final light = hsl
        .withLightness((hsl.lightness + 0.08).clamp(0.0, 1.0))
        .toColor();
    final dark = hsl
        .withLightness((hsl.lightness - 0.06).clamp(0.0, 1.0))
        .toColor();

    return Container(
      width: size.r,
      height: size.r,
      decoration: BoxDecoration(
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isCircle ? null : BorderRadius.circular(8.r),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [light, dark],
        ),
        boxShadow: [
          BoxShadow(
            color: base.withAlpha(60),
            blurRadius: (size * 0.2).r,
            offset: Offset(0, (size * 0.08).r),
          ),
        ],
      ),
      child: Center(
        child: icon == null
            ? null
            : PhosphorIcon(
                icon,
                color: Colors.white,
                size: (size * _iconRatio).r,
              ),
      ),
    );
  }
}

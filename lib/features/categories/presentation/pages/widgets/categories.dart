import 'package:flutter/material.dart';
import '../../../data/models/category_model.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/custom_grid.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/custom_category_icon.dart';
import '../../../../../core/extensions/category_extension.dart';

class Categories extends StatelessWidget {
  final EdgeInsets? padding;
  final double childAspectRatio;
  final Function(CategoryModel)? onTap;
  final List<CategoryModel> categories;
  final CategoryModel? selectedCategory;
  const Categories({
    super.key,
    this.onTap,
    this.padding,
    this.selectedCategory,
    required this.categories,
    this.childAspectRatio = 0.96,
  });

  @override
  Widget build(BuildContext context) {
    return CustomGrid<CategoryModel>(
      items: categories,
      childAspectRatio: childAspectRatio,
      padding: padding ?? EdgeInsets.all(12.h),
      itemBuilder: (context, category) => _Item(
        onTap: onTap,
        category: category,
        selectedCategory: selectedCategory,
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final CategoryModel category;
  final CategoryModel? selectedCategory;
  final Function(CategoryModel)? onTap;
  const _Item({
    required this.onTap,
    required this.category,
    required this.selectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = category == selectedCategory;
    return GestureDetector(
      onTap: () => onTap?.call(category),
      child: _ItemBody(isSelected: isSelected, category: category),
    );
  }
}

class _ItemBody extends StatelessWidget {
  final bool isSelected;
  final CategoryModel category;
  const _ItemBody({required this.category, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    final color = Color(category.color);
    final cardColor = Theme.of(context).cardColor;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isSelected
            ? Color.alphaBlend(color.withAlpha(30), cardColor)
            : cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          width: 1.5,
          color: isSelected ? color : Colors.transparent,
        ),
        boxShadow: [
          BoxShadow(
            color: isSelected
                ? color.withAlpha(60)
                : Colors.black.withAlpha(13),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomCategoryIcon(size: 45.sp, color: color, category: category),
          CustomText(
            maxLines: 1,
            type: Type.header,
            textAlign: TextAlign.center,
            text: category.name,
            size: category.name.getSize(),
          ),
        ],
      ),
    );
  }
}

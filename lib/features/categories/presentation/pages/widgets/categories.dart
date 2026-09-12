import 'package:flutter/material.dart';
import '../../../../../const/app_data.dart';
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
    bool isSelected = category == selectedCategory;
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
    var color = Color(category.color);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        boxShadow: defaultBoxShadow,
        color: isSelected ? color.withAlpha(45) : Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(
          width: isSelected ? 2 : 0,
          color: isSelected ? color : Colors.transparent,
        ),
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

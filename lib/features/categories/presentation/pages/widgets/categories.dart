import 'package:flutter/material.dart';
import '../../../../../const/app_data.dart';
import '../../../data/models/category_model.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/custom_grid.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:surrah/core/extensions/icon_extensions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../core/extensions/category_extension.dart';

class Categories extends StatelessWidget {
  final Function(CategoryModel)? onTap;
  final CategoryModel? selectedCategory;
  final List<CategoryModel> categories;
  const Categories({
    super.key,
    this.onTap,
    required this.categories,
    this.selectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    return CustomGrid<CategoryModel>(
      items: categories,
      padding: EdgeInsets.all(12.h),
      itemBuilder: (context, category) => _Item(
        onTap: onTap ?? (_) {},
        category: category,
        isSelected: selectedCategory != null
            ? category == selectedCategory
            : false,
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final bool isSelected;
  final CategoryModel category;
  final Function(CategoryModel) onTap;
  const _Item({
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var color = Color(category.color);
    return GestureDetector(
      onTap: () => onTap(category),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          boxShadow: defaultBoxShadow,
          color: isSelected ? color.withAlpha(45) : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(
            width: isSelected ? 2 : 0,
            color: isSelected ? color : Colors.transparent,
          ),
        ),
        child: _ItemBody(category: category),
      ),
    );
  }
}

class _ItemBody extends StatelessWidget {
  final CategoryModel category;
  const _ItemBody({required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 6.h,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FaIcon(
          size: 26.sp,
          color: Color(category.color),
          category.iconId.getIconById()?.icon,
        ),
        CustomText(
          maxLines: 2,
          type: Type.header,
          text: category.name,
          textAlign: TextAlign.center,
          size: category.name.getSize(),
        ),
      ],
    );
  }
}

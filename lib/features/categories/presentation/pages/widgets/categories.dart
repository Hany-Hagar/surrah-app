import 'add_edit_category.dart';
import 'package:flutter/material.dart';
import '../../../../../const/app_data.dart';
import 'package:surrah/generated/l10n.dart';
import '../../../data/models/category_model.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/custom_grid.dart';
import '../../../../../core/services/dialog_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:surrah/core/extensions/icon_extensions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../core/extensions/category_extension.dart';

class Categories extends StatelessWidget {
  final bool showAddItem;
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
    required this.showAddItem,
    this.childAspectRatio = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomGrid<CategoryModel>(
      items: categories,
      childAspectRatio: childAspectRatio,
      padding: padding ?? EdgeInsets.all(12.h),
      extraItem: showAddItem ? const _AddItem() : null,
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
    var color = Color(category.color);
    bool isSelected = category == selectedCategory;
    return GestureDetector(
      onTap: () => onTap?.call(category),
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
  final FaIconData? icon;
  final String? name;
  final Color? color;
  final CategoryModel? category;
  const _ItemBody({this.category, this.icon, this.name, this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8.h,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FaIcon(
          size: 25.sp,
          color: color ?? Color(category!.color),
          icon ?? category!.iconId.getIconById()?.icon,
        ),
        CustomText(
          maxLines: 2,
          type: Type.header,
          text: name ?? category!.name,
          textAlign: TextAlign.center,
          size: (name ?? category!.name).getSize(),
        ),
      ],
    );
  }
}

class _AddItem extends StatelessWidget {
  const _AddItem();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => DialogService.showCustomDialog(
        context: context,
        body: const AddEditCategory(),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          boxShadow: defaultBoxShadow,
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: _ItemBody(
          name: S.of(context).addCategory,
          color: Color(0xFF607D8B),
          icon: FontAwesomeIcons.plus,
        ),
      ),
    );
  }
}

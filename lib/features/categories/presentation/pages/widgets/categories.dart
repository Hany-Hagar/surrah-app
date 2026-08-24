import 'package:flutter/material.dart';
import '../../../../../const/app_data.dart';
import '../../../data/models/category_model.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/custom_grid.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:surrah/core/extensions/icon_extensions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../core/extensions/category_extension.dart';
import '../../manager/categories_cubit.dart';

class Categories extends StatelessWidget {
  final Function(CategoryModel)? onTap;
  final List<CategoryModel> categories;
  final CategoryModel? selectedCategory;
  const Categories({
    super.key,
    this.onTap,
    required this.categories,
    this.selectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = CategoriesCubit.get(context);
    return CustomGrid<CategoryModel>(
      items: categories,
      padding: EdgeInsets.all(12.h),
      extraItem: cubit.isSearching || cubit.isFiltering
          ? null
          : const _AddItem(),
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
  final String? name;
  final Color? color;
  final FaIconData? icon;
  final CategoryModel? category;
  final Function(CategoryModel)? onTap;
  const _Item({
    this.icon,
    this.name,
    this.color,
    this.onTap,
    this.category,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(category!),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          boxShadow: defaultBoxShadow,
          color: isSelected
              ? color!.withAlpha(45)
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(
            width: isSelected ? 2 : 0,
            color: isSelected ? color! : Colors.transparent,
          ),
        ),
        child: _ItemBody(
          category: category,
          icon: icon,
          name: name,
          color: color,
        ),
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
          size: 26.sp,
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
      onTap: () {},
      child: _Item(
        icon: FontAwesomeIcons.plus,
        name: 'إضافة تصنيف',
        color: Color(0xFF607D8B),
      ),
    );
  }
}

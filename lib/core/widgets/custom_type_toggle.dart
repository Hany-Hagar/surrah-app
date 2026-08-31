import 'custom_toggle.dart';
import '../enums/category_type.dart';
import 'package:flutter/material.dart';
import '../extensions/categories_type_extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTypeToggle extends StatelessWidget {
  final bool showAll;
  final CategoriesType selectedType;
  final Function(CategoriesType) onChanged;
  const CustomTypeToggle({
    super.key,
    this.showAll = false,
    required this.selectedType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CustomToggle<CategoriesType>(
      height: 60.h,
      selectedItem: selectedType,
      onChanged: (value) => onChanged(value),
      itemLabel: (item) => item.toLocalization(context: context),
      items: [
        if (showAll) CategoriesType.all,
        CategoriesType.income,
        CategoriesType.expense,
      ],
    );
  }
}

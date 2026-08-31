import 'custom_text.dart';
import 'custom_toggle.dart';
import '../enums/category_type.dart';
import 'package:flutter/material.dart';
import '../extensions/categories_type_extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTypeToggle extends StatelessWidget {
  final bool showAll;
  final String title;
  final CategoriesType selectedType;
  final Function(CategoriesType) onChanged;
  const CustomTypeToggle({
    super.key,
    required this.title,
    this.showAll = false,
    required this.onChanged,
    required this.selectedType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8.h,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: title, size: 18.sp, type: Type.header),
        CustomToggle<CategoriesType>(
          height: 60.h,
          selectedItem: selectedType,
          onChanged: (value) => onChanged(value),
          itemLabel: (item) => item.toLocalization(context: context),
          items: [
            if (showAll) CategoriesType.all,
            CategoriesType.income,
            CategoriesType.expense,
          ],
        ),
      ],
    );
  }
}

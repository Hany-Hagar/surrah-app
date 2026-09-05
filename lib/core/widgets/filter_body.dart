import 'custom_text.dart';
import 'custom_toggle.dart';
import '../enums/category_type.dart';
import 'package:flutter/material.dart';
import '../../../../../generated/l10n.dart';
import '../extensions/categories_type_extensions.dart';
import '../../../../../core/widgets/custom_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterBody extends StatelessWidget {
  final Widget? body;
  final bool isFiltering;
  final Function clearFilter;
  final Function applyFilter;
  final bool showAllCategoriesType;
  final CategoriesType? selectedType;
  final Function(CategoriesType)? onTypeChanged;
  const FilterBody({
    super.key,
    this.body,
    required this.isFiltering,
    required this.clearFilter,
    required this.applyFilter,
    this.showAllCategoriesType = false,
    this.selectedType,
    this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.w).copyWith(top: 20.h, bottom: 22.h),
      child: Column(
        spacing: 4.h,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50.w,
            height: 3.h,
            decoration: BoxDecoration(
              color: Theme.of(context).disabledColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          if (isFiltering) _ClearFilter(clearFilter: clearFilter),
          if (selectedType != null && onTypeChanged != null)
            _TypeToggle(
              onChanged: onTypeChanged!,
              selectedType: selectedType!,
              showAll: showAllCategoriesType,
            ),
          ?body,
          _Button(applyFilter: applyFilter),
        ],
      ),
    );
  }
}

class _ClearFilter extends StatelessWidget {
  final Function clearFilter;
  const _ClearFilter({required this.clearFilter});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).colorScheme.primary;
    return GestureDetector(
      onTap: () {
        clearFilter();
        Navigator.pop(context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.filter_alt_off, size: 24.sp, color: color),
          SizedBox(width: 8.w),
          CustomText(
            text: S.of(context).clearFilterButton,
            size: 18.sp,
            type: Type.overMedium,
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final Function applyFilter;
  const _Button({required this.applyFilter});

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    return SizedBox(
      height: 48.h,
      child: Row(
        spacing: 12.w,
        children: [
          Expanded(
            child: CustomButton(
              text: s.filterButton,
              onPressed: () {
                applyFilter();
                Navigator.pop(context);
              },
            ),
          ),
          Expanded(
            child: CustomButton(
              text: s.cancel,
              //color: Colors.red,
              enableBorderColor: true,
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}

class _TypeToggle extends StatelessWidget {
  final bool showAll;
  final CategoriesType selectedType;
  final Function(CategoriesType) onChanged;
  const _TypeToggle({
    this.showAll = false,
    required this.onChanged,
    required this.selectedType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 3.h,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: S.of(context).categoryType,
          size: 18.sp,
          type: Type.header,
        ),
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

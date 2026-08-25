import 'package:flutter/material.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/categories_cubit.dart';
import '../../manager/categories_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/enums/category_type.dart';
import '../../../../../core/widgets/custom_toggle.dart';
import '../../../../../core/widgets/custom_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/categories_type_extensions.dart';

class CategoriesFilter extends StatelessWidget {
  const CategoriesFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesStates>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(12.w).copyWith(top: 20.h, bottom: 22.h),
          child: Column(
            spacing: 12.h,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 50.w,
                  height: 3.h,
                  decoration: BoxDecoration(
                    color: Theme.of(context).disabledColor,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
              _Body(),
              _Button(),
            ],
          ),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    return Column(
      spacing: 8.h,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(text: s.categoryType, size: 17, type: Type.overMedium),
            _ClearFilter(isFiltering: CategoriesCubit.get(context).isFiltering),
          ],
        ),
        CustomToggle(
          height: 60.h,
          items: CategoriesType.values,
          selectedItem: CategoriesCubit.get(context).selectedType,
          onChanged: (value) =>
              CategoriesCubit.get(context).changeSelectedType(value),
          itemLabel: (item) => item.toLocalization(context: context),
        ),
      ],
    );
  }
}

class _ClearFilter extends StatelessWidget {
  final bool isFiltering;
  const _ClearFilter({required this.isFiltering});

  @override
  Widget build(BuildContext context) {
    var cubit = CategoriesCubit.get(context);
    return Visibility(
      visible: isFiltering,
      child: GestureDetector(
        onTap: () {
          cubit.clearFilter();
          Navigator.pop(context);
        },
        child: Row(
          children: [
            Icon(Icons.filter_alt_off),
            SizedBox(width: 8.w),
            CustomText(
              text: S.of(context).clearFilterButton,
              size: 15,
              type: Type.medium,
            ),
          ],
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button();

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
                CategoriesCubit.get(context).filterCategories();
                Navigator.pop(context);
              },
            ),
          ),
          Expanded(
            child: CustomButton(
              text: s.cancel,
              color: Colors.red,
              enableBorderColor: true,
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}

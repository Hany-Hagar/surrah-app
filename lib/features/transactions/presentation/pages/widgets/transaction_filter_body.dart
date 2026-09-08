import 'package:flutter/material.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/transactions_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../manager/transactions_states.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/custom_tabs.dart';
import '../../../../../core/widgets/filter_body.dart';
import '../../../../../core/enums/date_filter_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../categories/data/models/category_model.dart';
import '../../../../../core/extensions/date_filter_type_extensions.dart';

class TransactionFilterBody extends StatelessWidget {
  const TransactionFilterBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsCubit, TransactionsStates>(
      builder: (context, state) {
        var cubit = TransactionsCubit.get(context);
        return FilterBody(
          showAllCategoriesType: true,
          isFiltering: cubit.isFiltering,
          selectedType: cubit.selectedType,
          clearFilter: () => cubit.clearFilter(),
          applyFilter: () => cubit.filterCategories(),
          body: [
            _Categories(categories: cubit.filteredCategories),
            _Date(),
          ],
          onTypeChanged: (value) => cubit.changeSelectedType(value),
        );
      },
    );
  }
}

class _Categories extends StatelessWidget {
  final List<CategoryModel> categories;
  const _Categories({required this.categories});

  @override
  Widget build(BuildContext context) {
    var cubit = TransactionsCubit.get(context);
    var selectedCategories = cubit.selectedFilteredCategories;
    return categories.isNotEmpty
        ? Column(
            spacing: 6.h,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: CustomText(
                  text: S.of(context).categories,
                  size: 18.sp,
                  type: Type.header,
                ),
              ),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                alignment: WrapAlignment.start,
                children: categories
                    .map(
                      (category) => _Category(
                        category: category,
                        isSelected: selectedCategories.contains(category),
                      ),
                    )
                    .toList(),
              ),
            ],
          )
        : SizedBox.shrink();
  }
}

class _Category extends StatelessWidget {
  final bool isSelected;
  final CategoryModel category;
  const _Category({required this.isSelected, required this.category});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var color = isSelected ? theme.colorScheme.secondary.withAlpha(45) : theme.cardColor;
    return GestureDetector(
      onTap: () => TransactionsCubit.get(
        context,
      ).toggleCategorySelection(category: category),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(
            width: 1.5.w,
            color: isSelected ? theme.colorScheme.secondary : Color(0xFFBDBDBD),
          ),
        ),
        child: CustomText(text: category.name, size: 15.sp, type: Type.header),
      ),
    );
  }
}

class _Date extends StatelessWidget {
  const _Date();

  @override
  Widget build(BuildContext context) {
    var cubit = TransactionsCubit.get(context);
    var selected = cubit.selectedDateFilterTypes;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: "Date", size: 18.sp, type: Type.header),
        SizedBox(height: 8.h),
        CustomTabs<DateFilterType>(
          bodies: List.generate(
            DateFilterType.values.length,
            (index) => SizedBox.shrink(),
          ),
          selectedValue: selected,
          tabs: DateFilterType.values,
          labelBuilder: (value) => value.label(context: context),
          onTabChanged: (value) => cubit.toggleDateFilterType(type: value),
        ),
      ],
    );
  }
}



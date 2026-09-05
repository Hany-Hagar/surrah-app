import 'package:flutter/material.dart';
import '../widgets/transactions_body.dart';
import '../../../../../generated/l10n.dart';
import 'package:icon_broken/icon_broken.dart';
import '../../manager/transactions_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../manager/transactions_states.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/filter_body.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../categories/data/models/category_model.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';

class TransactionsView extends StatelessWidget {
  const TransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        bottomHeight: 60,
        bottom: const _Search(),
        title: s.transactionsTitle,
        trailingIcon: IconBroken.Filter,
        subtitle: s.transactionsSubtitle,
        onTrailingPressed: () {
          TransactionsCubit.get(context).initFilter();
          showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
            ),
            builder: (context) => const _Filter(),
          );
        },
      ),
      body: const TransactionsBody(),
    );
  }
}

class _Search extends StatelessWidget {
  const _Search();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsCubit, TransactionsStates>(
      builder: (context, state) {
        var cubit = TransactionsCubit.get(context);
        return CustomTextFormField(
          prefixIcon: IconBroken.Search,
          controller: cubit.searchController,
          hintText: S.of(context).searchTransactionsHint,
          suffixIcon: cubit.isSearching ? Icons.clear : null,
          suffixTap: () => cubit.searchTransactions(query: null),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          onChanged: (value) => cubit.searchTransactions(query: value),
        );
      },
    );
  }
}

class _Filter extends StatelessWidget {
  const _Filter();

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
          body: Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: _Categories(categories: cubit.filteredCategories),
          ),
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
    var color = isSelected ? theme.primaryColor.withAlpha(45) : theme.cardColor;
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
            color: isSelected ? theme.primaryColor : Color(0xFFBDBDBD),
          ),
        ),
        child: CustomText(text: category.name, size: 15.sp, type: Type.header),
      ),
    );
  }
}

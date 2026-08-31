import '../di/server_locator.dart';
import '../enums/category_type.dart';
import '../widgets/custom_text.dart';
import 'package:flutter/material.dart';
import '../services/dialog_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../features/categories/data/models/category_model.dart';
import '../../features/categories/presentation/pages/widgets/categories.dart';
import '../../features/categories/presentation/manager/categories_cubit.dart';

class CategoriesPicker {
  static Future<CategoryModel?> show({
    required BuildContext context,
    required CategoriesType categoriesType,
    required CategoryModel selectedCategory,
  }) async {
    var cubit = getIt<CategoriesCubit>();
    List<CategoryModel> categories = [];
    switch (categoriesType) {
      case CategoriesType.income:
        categories = cubit.incomeCategories;
        break;
      case CategoriesType.expense:
        categories = cubit.expenseCategories;
        break;
      case CategoriesType.all:
        categories = cubit.categories;
        break;
    }

    return await DialogService.showCustomDialog<CategoryModel>(
      context: context,
      padding: EdgeInsets.all(12.w).copyWith(top: 8.w),
      body: Column(
        spacing: 8.w,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Title(),
          _Body(categories: categories, selectedCategory: selectedCategory),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8.w,
      children: [
        CustomText(
          text: "🏷️",
          size: 20.sp,
          type: Type.overMedium,
        ),
        CustomText(
          text: "Select a category",
          size: 18.sp,
          type: Type.overMedium,
        ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final List<CategoryModel> categories;
  final CategoryModel? selectedCategory;
  const _Body({required this.categories, required this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.r),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Categories(
        showAddItem: false,
        childAspectRatio: 0.9,
        categories: categories,
        padding: EdgeInsets.zero,
        selectedCategory: selectedCategory,
        onTap: (category) => Navigator.pop(context, category),
      ),
    );
  }
}

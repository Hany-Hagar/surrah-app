import 'categories.dart';
import 'add_edit_category.dart';
import 'package:flutter/material.dart';
import '../../manager/categories_cubit.dart';
import '../../manager/categories_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/services/dialog_service.dart';

class CategoriesBody extends StatelessWidget {
  const CategoriesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesStates>(
      builder: (context, state) {
        var cubit = CategoriesCubit.get(context);
        var categories = cubit.isSearching
            ? cubit.searchResults
            : cubit.isFiltering
            ? cubit.filteredCategories
            : cubit.categories;
        return Categories(
          categories: categories,
          showAddItem: cubit.isSearching || cubit.isFiltering,
          onTap: (category) {
            cubit.initEditCategory(category: category);
            DialogService.showCustomDialog(
              context: context,
              body: AddEditCategory(isEdit: true, category: category),
            );
          },
        );
      },
    );
  }
}

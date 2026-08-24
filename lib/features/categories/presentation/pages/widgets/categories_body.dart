import 'categories.dart';
import 'package:flutter/material.dart';
import '../../manager/categories_cubit.dart';
import '../../manager/categories_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesBody extends StatelessWidget {
  const CategoriesBody({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = CategoriesCubit.get(context);
    return BlocBuilder<CategoriesCubit, CategoriesStates>(
      builder: (context, state) {
        var categories = cubit.isSearching ? cubit.searchResults : cubit.isFiltering ? cubit.filteredCategories : cubit.allCategories;
        return Categories(categories: categories);
      },
    );
  }
}

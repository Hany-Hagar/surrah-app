import 'categories_states.dart';
import 'package:flutter/material.dart';
import '../../data/repo/categories_repo.dart';
import '../../data/models/category_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/enums/category_type.dart';
import '../../data/database/default_categories.dart';
import '../../../../core/extensions/category_extension.dart';

class CategoriesCubit extends Cubit<CategoriesStates> {
  final CategoriesRepo categoriesRepo;
  CategoriesCubit({required this.categoriesRepo}) : super(CategoriesInitial());
  static CategoriesCubit get(BuildContext context) => BlocProvider.of(context);

  // Categories
  List<CategoryModel> allCategories = [];
  CategoryModel selectedCategory = DefaultCategories.income.first;
  List<CategoryModel> incomeCategories = DefaultCategories.income;
  List<CategoryModel> expenseCategories = DefaultCategories.expense;

  void getCategories() async {
    if (allCategories.isNotEmpty) {
      return;
    }
    emit(CategoriesLoading());
    var categories = await categoriesRepo.getCategories();
    categories.fold(
      (failure) => emit(CategoriesFailure(errorMessage: failure.message)),
      (categories) {
        allCategories.addAll([...DefaultCategories.all, ...categories]);
        selectedCategory = allCategories.first;
        emit(CategoriesSuccess());
      },
    );
  }

  // Search & Filter
  bool isSearching = false;
  bool isFiltering = false;
  List<CategoryModel> searchResults = [];
  List<CategoryModel> filteredCategories = [];
  var searchController = TextEditingController();
  CategoriesType selectedType = CategoriesType.all;

  void searchCategories({required String? query}) {
    if (query == null || query.isEmpty) {
      isSearching = false;
      searchResults.clear();
      searchController.clear();
      emit(CategoriesSearch());
      return;
    }
    isSearching = true;
    if (isFiltering) {
      searchResults = filteredCategories.search(query);
    } else {
      searchResults = allCategories.search(query);
    }
    emit(CategoriesSearch());
  }

  void changeSelectedType(CategoriesType type) {
    selectedType = type;
    emit(CategoriesSearch());
  }

  void filterCategories() {
    isFiltering = true;
    filteredCategories = allCategories.filterByType(selectedType);
    emit(CategoriesSearch());
  }

  void clearFilter() {
    isFiltering = false;
    searchResults.clear();
    selectedType = CategoriesType.all;
    emit(CategoriesSearch());
  }
}

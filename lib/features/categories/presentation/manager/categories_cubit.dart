import '../../../../core/extensions/category_extension.dart';
import 'categories_states.dart';
import 'package:flutter/material.dart';
import '../../data/repo/categories_repo.dart';
import '../../data/models/category_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/database/default_categories.dart';

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

  // Search
  bool isSearching = false;
  List<CategoryModel> searchResults = [];
  var searchController = TextEditingController();

  void searchCategories({required String? query}) {
    if (query == null || query.isEmpty) {
      isSearching = false;
      searchResults.clear();
      searchController.clear();
      emit(CategoriesSearchSuccess());
      return;
    }
    isSearching = true;
    emit(CategoriesSearchLoading());
    searchResults = allCategories.search(query);
    emit(CategoriesSearchSuccess());
  }
}

import 'dart:developer';
import 'categories_states.dart';
import 'package:flutter/material.dart';
import '../../data/repo/categories_repo.dart';
import '../../data/models/category_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/server_locator.dart';
import '../../../../core/enums/category_type.dart';
import '../../data/database/default_categories.dart';
import '../../../iconPicker/data/database/icons.dart';
import '../../../iconPicker/data/models/icon_model.dart';
import '../../../../core/extensions/icon_extensions.dart';
import '../../../../core/extensions/category_extension.dart';
import '../../../iconPicker/presentations/pages/icon_picker_dialog.dart';
import '../../../transactions/presentation/manager/transactions_cubit.dart';

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
        getIt<TransactionsCubit>().getTransactions();
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
  var autoValidateMode = AutovalidateMode.disabled;

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

  // Add & Edit Category
  Color selectedColor = Colors.blue;
  IconModel selectedIcon = iconsData.first;
  TextEditingController nameController = TextEditingController();
  CategoriesType selectedCategoryType = CategoriesType.income;

  void updateLists({required CategoryModel category, required bool isEdit}) {
    if (!isEdit) {
      allCategories.add(category);
      if (category.isIncome) {
        incomeCategories.add(category);
      } else {
        expenseCategories.add(category);
      }
    } else {
      allCategories = allCategories
          .map((c) => c.id == category.id ? category : c)
          .toList();
      if (category.isIncome) {
        incomeCategories = incomeCategories
            .map((c) => c.id == category.id ? category : c)
            .toList();
      } else {
        expenseCategories = expenseCategories
            .map((c) => c.id == category.id ? category : c)
            .toList();
      }
    }
  }

  void changeSelectedCategoryType({required CategoriesType type}) {
    selectedCategoryType = type;
    emit(ChangeSelectedCategory());
  }

  void changeSelectedIconData({required BuildContext context}) {
    IconPicker.show(context).then((value) {
      selectedIcon = value.icon;
      selectedColor = value.color;
      emit(SetIconDataStates());
    });
  }

  CategoryModel setCategoryModel() {
    return CategoryModel.newCategory(
      iconId: selectedIcon.id,
      name: nameController.text,
      color: selectedColor.toARGB32(),
      isIncome: selectedCategoryType == CategoriesType.income,
    );
  }

  void addCategory({required GlobalKey<FormState> formKey}) async {
    if (!formKey.currentState!.validate()) {
      autoValidateMode = AutovalidateMode.onUserInteraction;
      emit(AutoValidateModeChanged());
      return;
    }
    emit(AddCategoryLoading());
    var newCategory = setCategoryModel();
    log("Adding new category: ${newCategory.name}");
    log(
      "Icon ID: ${newCategory.iconId}, Color: ${newCategory.color}, Is Income: ${newCategory.isIncome}",
    );
    var result = await categoriesRepo.addCategory(newCategory);
    result.fold(
      (failure) => emit(UpdateCategoriesFailure(errorMessage: failure.message)),
      (category) {
        autoValidateMode = AutovalidateMode.disabled;
        updateLists(category: category, isEdit: false);
        emit(AddCategorySuccess());
      },
    );
  }

  // Edit Category
  void initEditCategory({required CategoryModel category}) {
    selectedCategory = category;
    nameController.text = category.name;
    selectedColor = Color(category.color);
    selectedIcon = category.iconId.getIconById()!;
    selectedCategoryType = category.isIncome
        ? CategoriesType.income
        : CategoriesType.expense;
  }

  void updateCategory({
    required GlobalKey<FormState> formKey,
    required CategoryModel category,
  }) async {
    if (!formKey.currentState!.validate()) {
      autoValidateMode = AutovalidateMode.onUserInteraction;
      emit(AutoValidateModeChanged());
      return;
    }
    emit(UpdateCategoryLoading());
    var updatedCategory = category.copyWith(
      name: nameController.text,
      iconId: selectedIcon.id,
      color: selectedColor.toARGB32(),
      isIncome: selectedCategoryType == CategoriesType.income,
    );
    var result = await categoriesRepo.updateCategory(updatedCategory);
    result.fold(
      (failure) => emit(UpdateCategoriesFailure(errorMessage: failure.message)),
      (category) {
        autoValidateMode = AutovalidateMode.disabled;
        updateLists(category: category, isEdit: true);
        emit(UpdateCategorySuccess());
      },
    );
  }

  void resetAddCategoryData() {
    nameController.clear();
    selectedColor = Colors.blue;
    selectedIcon = iconsData.first;
    selectedCategoryType = CategoriesType.income;
    autoValidateMode = AutovalidateMode.disabled;
  }
}

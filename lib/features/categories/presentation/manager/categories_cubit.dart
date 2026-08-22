import 'categories_states.dart';
import 'package:flutter/material.dart';
import '../../data/repo/categories_repo.dart';
import '../../data/models/category_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/database/default_categories.dart';
import '../../../iconPicker/data/models/icon_model.dart';

class CategoriesCubit extends Cubit<CategoriesStates> {
  final CategoriesRepo categoriesRepo;
  CategoriesCubit({required this.categoriesRepo}) : super(CategoriesInitial());
  static CategoriesCubit get(BuildContext context) => BlocProvider.of(context);

  // Categories
  List<CategoryModel> incomeCategories = DefaultCategories.income;
  List<CategoryModel> expenseCategories = DefaultCategories.expense;

  // Get all categories
  Future<void> getAllCategories() async {
    emit(CategoriesLoading());
    final result = await categoriesRepo.getAllCategories();
    result.fold(
      (failure) => emit(CategoriesFailure(errorMessage: failure.message)),
      (categories) {
        for (var category in categories) {
          if (category.isIncome) {
            incomeCategories.add(category);
          } else {
            expenseCategories.add(category);
          }
        }
        emit(CategoriesSuccess());
      },
    );
  }

  // Add & Edit category
  late IconModel selectedIcon;
  int selectedColor = 0xFF2196F3;
  TextEditingController nameController = TextEditingController();
  void setIconData({required IconModel icon, required int color}) {
    selectedIcon = icon;
    selectedColor = color;
    emit(SetIconDataStates());
  }

  Future<void> addCategory({
    required GlobalKey<FormState> formKey,
    required bool isIncome,
  }) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    emit(CategoriesLoading());
    final newCategory = CategoryModel(
      isIncome: isIncome,
      color: selectedColor,
      iconId: selectedIcon.id,
      name: nameController.text,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
    );
    final result = await categoriesRepo.addCategory(newCategory);
    result.fold(
      (failure) => emit(CategoriesFailure(errorMessage: failure.message)),
      (_) {
        if (newCategory.isIncome) {
          incomeCategories.add(newCategory);
        } else {
          expenseCategories.add(newCategory);
        }
        emit(CategoriesSuccess());
      },
    );
  }

  Future<void> updateCategory({
    required GlobalKey<FormState> formKey,
    required CategoryModel category,
  }) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    emit(CategoriesLoading());
    final updatedCategory = category.copyWith(
      name: nameController.text,
      color: selectedColor,
      iconId: selectedIcon.id,
    );
    final result = await categoriesRepo.updateCategory(updatedCategory);
    result.fold(
      (failure) => emit(CategoriesFailure(errorMessage: failure.message)),
      (_) {
        if (updatedCategory.isIncome) {
          final index = incomeCategories.indexWhere(
            (c) => c.id == updatedCategory.id,
          );
          if (index != -1) {
            incomeCategories[index] = updatedCategory;
          }
        } else {
          final index = expenseCategories.indexWhere(
            (c) => c.id == updatedCategory.id,
          );
          if (index != -1) {
            expenseCategories[index] = updatedCategory;
          }
        }
        emit(CategoriesSuccess());
      },
    );
  }

  // Delete category
  Future<void> deleteCategory(CategoryModel category) async {
    emit(CategoriesLoading());
    final result = await categoriesRepo.deleteCategory(category.id);
    result.fold(
      (failure) => emit(CategoriesFailure(errorMessage: failure.message)),
      (_) {
        if (category.isIncome) {
          incomeCategories.removeWhere((c) => c.id == category.id);
        } else {
          expenseCategories.removeWhere((c) => c.id == category.id);
        }
        emit(CategoriesSuccess());
      },
    );
  }
}

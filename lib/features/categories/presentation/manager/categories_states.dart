sealed class CategoriesStates {}

class CategoriesInitial extends CategoriesStates {}

// Get Categories
class CategoriesLoading extends CategoriesStates {}

class CategoriesSuccess extends CategoriesStates {}

class CategoriesFailure extends CategoriesStates {
  final String errorMessage;
  CategoriesFailure({required this.errorMessage});
}

// Search Categories
class CategoriesSearch extends CategoriesStates {}

// Filter Categories
class ChangeSelectedType extends CategoriesStates {}

class FilterCategories extends CategoriesStates {}

// Category Data
class ChangeSelectedCategory extends CategoriesStates {}

class SetIconDataStates extends CategoriesStates {}

// Add Category
class AutoValidateModeChanged extends CategoriesStates {}

class AddCategoryLoading extends CategoriesStates {}

class AddCategorySuccess extends CategoriesStates {}

class AddCategoryFailure extends CategoriesStates {
  final String errorMessage;
  AddCategoryFailure({required this.errorMessage});
}

// Update Category
class UpdateCategoryLoading extends CategoriesStates {}

class UpdateCategorySuccess extends CategoriesStates {}

class UpdateCategoryFailure extends CategoriesStates {
  final String errorMessage;
  UpdateCategoryFailure({required this.errorMessage});
}

// Delete Category
class DeleteCategoryLoading extends CategoriesStates {}

class DeleteCategorySuccess extends CategoriesStates {}

class DeleteCategoryFailure extends CategoriesStates {
  final String errorMessage;
  DeleteCategoryFailure({required this.errorMessage});
}

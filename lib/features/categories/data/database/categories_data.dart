import '../models/category_model.dart';
import '../../../../const/hive_data.dart';
import '../../../../core/services/hive_service.dart';

class CategoriesData {
  final HiveService hiveService;
  CategoriesData({required this.hiveService});

  // Get all categories
  List<CategoryModel> getAllCategories() {
    final box = hiveService.box<CategoryModel>(HiveData.categoriesBox);
    return box.values.toList();
  }

  // Add a new category
  Future<void> addCategory(CategoryModel category) async {
    await hiveService.add<CategoryModel>(
      boxName: HiveData.categoriesBox,
      value: category,
    );
  }

  // Update an existing category
  Future<void> updateCategory(CategoryModel category) async {
    await hiveService.put<CategoryModel>(
      boxName: HiveData.categoriesBox,
      key: category.id,
      value: category,
    );
  }

  // Delete a category
  Future<void> deleteCategory(String categoryId) async {
    await hiveService.delete(
      boxName: HiveData.categoriesBox,
      key: categoryId,
    );
  }
}

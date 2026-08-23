import 'package:dartz/dartz.dart';
import '../models/category_model.dart';
import '../../../../core/errors/failure.dart';

abstract class CategoriesRepo {
  Future<Either<Failure, List<CategoryModel>>> getCategories();
  Future<Either<Failure, void>> addCategory(CategoryModel category);
  Future<Either<Failure, void>> updateCategory(CategoryModel category);
  Future<Either<Failure, void>> deleteCategory(String categoryId);
}

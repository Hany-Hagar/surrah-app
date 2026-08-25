import 'package:dartz/dartz.dart';
import '../models/category_model.dart';
import '../../../../core/errors/failure.dart';

abstract class CategoriesRepo {
  Future<Either<Failure, List<CategoryModel>>> getCategories();
  Future<Either<Failure, CategoryModel>> addCategory(CategoryModel category);
  Future<Either<Failure, CategoryModel>> updateCategory(CategoryModel category);
}

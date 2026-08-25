import 'categories_repo.dart';
import 'package:dartz/dartz.dart';
import '../models/category_model.dart';
import '../database/categories_data.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/hive_failure.dart';

class CategoriesRepoImpl extends CategoriesRepo {
  final CategoriesData categoriesData;
  CategoriesRepoImpl({required this.categoriesData});

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    try {
      final categories = categoriesData.getAllCategories();
      return Right(categories);
    } catch (e) {
      return Left(HiveFailure.fromError(e));
    }
  }

  @override
  Future<Either<Failure, CategoryModel>> addCategory(
    CategoryModel category,
  ) async {
    try {
      await categoriesData.addCategory(category);
      return Right(category);
    } catch (e) {
      return Left(HiveFailure.fromError(e));
    }
  }

  @override
  Future<Either<Failure, CategoryModel>> updateCategory(
    CategoryModel category,
  ) async {
    try {
      await categoriesData.updateCategory(category);
      return Right(category);
    } catch (e) {
      return Left(HiveFailure.fromError(e));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCategory(String categoryId) async {
    try {
      await categoriesData.deleteCategory(categoryId);
      return const Right(null);
    } catch (e) {
      return Left(HiveFailure.fromError(e));
    }
  }
}

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../features/categories/data/models/category_model.dart';
import '../enums/category_type.dart';

extension CategoryNameSize on String {
  double getSize() {
    if (length <= 5) {
      return 14.sp;
    } else if (length <= 10) {
      return 13.sp;
    } else {
      return 12.sp;
    }
  }
}

// Search extension
extension SearchExtension on List<CategoryModel> {
  List<CategoryModel> search(String query) {
    return where(
      (category) => category.name.toLowerCase().contains(query.toLowerCase()),
    ).toList();
  }
}

// Filter extension
extension FilterExtension on List<CategoryModel> {
  List<CategoryModel> filterByType(CategoriesType type) {
    switch (type) {
      case CategoriesType.all:
        return this;
      case CategoriesType.income:
        return where((category) => category.isIncome).toList();
      case CategoriesType.expense:
        return where((category) => !category.isIncome).toList();
    }
  }
}

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../features/categories/data/models/category_model.dart';

extension CategoryNameSize on String {
  double getSize() {
    if (length <= 5) {
      return 14.sp;
    } else if (length <= 10) {
      return 13.sp;
    } else {
      return 11.sp;
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

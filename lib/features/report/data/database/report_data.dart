import 'package:surrah/features/categories/data/database/default_categories.dart';
import '../../../../const/hive_data.dart';
import '../../../../core/services/hive_service.dart';
import '../../../categories/data/models/category_model.dart';
import '../../../transactions/data/model/transactions_data_model.dart';

class ReportData {
  ReportData({required this.hiveService});

  final HiveService hiveService;

  TransactionsDataModel getTransactionsData() {
    final box = hiveService.box<TransactionsDataModel>(
      HiveData.transactionsDataBox,
    );
    return box.values.first;
  }

  List<CategoryModel> getCategoriesData() {
    final box = hiveService.box<CategoryModel>(HiveData.categoriesBox);
    final customCategories = box.values.toList();

    final Map<String, CategoryModel> merged = {
      for (final c in DefaultCategories.all) c.id: c,
      for (final c in customCategories) c.id: c,
    };

    return merged.values.toList();
  }
}
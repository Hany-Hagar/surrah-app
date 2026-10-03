import '../../const/hive_data.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../features/categories/data/models/category_model.dart';
import '../../features/transactions/data/model/balance_model.dart';
import '../../features/transactions/data/model/transaction_model.dart';
import '../../features/transactions/data/model/transactions_data_model.dart';

class HiveService {
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(CategoryModelAdapter());
    Hive.registerAdapter(TransactionModelAdapter());
    Hive.registerAdapter(BalanceModelAdapter());
    Hive.registerAdapter(TransactionsDataModelAdapter());
    await openBox<CategoryModel>(HiveData.categoriesBox);
    await openBox<TransactionModel>(HiveData.transactionsBox);
    await openBox<BalanceModel>(HiveData.balanceBox);
    await openBox<TransactionsDataModel>(HiveData.transactionsDataBox);
  }

  Future<Box<T>> openBox<T>(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openBox<T>(boxName);
    }
    return Hive.box<T>(boxName);
  }

  Box<T> box<T>(String boxName) {
    return Hive.box<T>(boxName);
  }

  Future<void> put<T>({
    required String boxName,
    required dynamic key,
    required T value,
  }) async {
    final targetBox = box<T>(boxName);
    String? valueId;
    try {
      valueId = (value as dynamic).id as String?;
    } catch (_) {}

    if (valueId != null) {
      final matchingKeys = targetBox.keys.where((boxKey) {
        final existingValue = targetBox.get(boxKey);
        try {
          return (existingValue as dynamic).id == valueId;
        } catch (_) {
          return false;
        }
      }).toList();

      if (matchingKeys.isNotEmpty) {
        await targetBox.put(matchingKeys.first, value);
        for (final matchingKey in matchingKeys.skip(1)) {
          await targetBox.delete(matchingKey);
        }
        return;
      }
    }

    await targetBox.put(key, value);
  }

  T? get<T>({required String boxName, required dynamic key}) {
    return box<T>(boxName).get(key);
  }

  Future<void> add<T>({required String boxName, required T value}) async {
    await box<T>(boxName).add(value);
  }

  Future<void> delete({required String boxName, required dynamic key}) async {
    await box(boxName).delete(key);
  }

  Future<void> clear(String boxName) async {
    await box(boxName).clear();
  }

  Future<void> close() async {
    await Hive.close();
  }
}

import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  Future<void> init() async {
    await Hive.initFlutter();
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
    await box<T>(boxName).put(key, value);
  }

  T? get<T>({
    required String boxName,
    required dynamic key,
  }) {
    return box<T>(boxName).get(key);
  }

  Future<void> add<T>({
    required String boxName,
    required T value,
  }) async {
    await box<T>(boxName).add(value);
  }

  Future<void> delete({
    required String boxName,
    required dynamic key,
  }) async {
    await box(boxName).delete(key);
  }

  Future<void> clear(String boxName) async {
    await box(boxName).clear();
  }

  Future<void> close() async {
    await Hive.close();
  }
}
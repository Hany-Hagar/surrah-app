import '../models/category_model.dart';

class DefaultCategories {
  static final List<CategoryModel> income = [
    CategoryModel(
      id: 'salary',
      name: 'الراتب',
      color: 0xFF4CAF50,
      iconId: 'salary',
      isIncome: true,
    ),
    CategoryModel(
      id: 'freelance',
      name: 'العمل الحر',
      color: 0xFF2196F3,
      iconId: 'work',
      isIncome: true,
    ),
    CategoryModel(
      id: 'business',
      name: 'الأعمال',
      color: 0xFF9C27B0,
      iconId: 'business',
      isIncome: true,
    ),
    CategoryModel(
      id: 'investment',
      name: 'الاستثمار',
      color: 0xFFFF9800,
      iconId: 'investment',
      isIncome: true,
    ),
    CategoryModel(
      id: 'gift_income',
      name: 'الهدايا',
      color: 0xFFE91E63,
      iconId: 'gift',
      isIncome: true,
    ),
    CategoryModel(
      id: 'other_income',
      name: 'دخل آخر',
      color: 0xFF607D8B,
      iconId: 'money',
      isIncome: true,
    ),
  ];
  static final List<CategoryModel> expense = [
    CategoryModel(
      id: 'housing',
      name: 'السكن',
      color: 0xFF795548,
      iconId: 'home',
      isIncome: false,
    ),
    CategoryModel(
      id: 'food',
      name: 'الطعام',
      color: 0xFFFF5722,
      iconId: 'food',
      isIncome: false,
    ),
    CategoryModel(
      id: 'transportation',
      name: 'المواصلات',
      color: 0xFF3F51B5,
      iconId: 'car',
      isIncome: false,
    ),
    CategoryModel(
      id: 'shopping',
      name: 'التسوق',
      color: 0xFFE91E63,
      iconId: 'shopping',
      isIncome: false,
    ),
    CategoryModel(
      id: 'health',
      name: 'الصحة',
      color: 0xFFF44336,
      iconId: 'health',
      isIncome: false,
    ),
    CategoryModel(
      id: 'education',
      name: 'التعليم',
      color: 0xFF009688,
      iconId: 'education',
      isIncome: false,
    ),
    CategoryModel(
      id: 'entertainment',
      name: 'الترفيه',
      color: 0xFF673AB7,
      iconId: 'entertainment',
      isIncome: false,
    ),
    CategoryModel(
      id: 'bills',
      name: 'الفواتير والاشتراكات',
      color: 0xFFFFC107,
      iconId: 'electricity',
      isIncome: false,
    ),
    CategoryModel(
      id: 'other_expense',
      name: 'مصاريف أخرى',
      color: 0xFF607D8B,
      iconId: 'money',
      isIncome: false,
    ),
  ];
  static List<CategoryModel> get all => [...income, ...expense];
}

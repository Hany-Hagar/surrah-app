import 'date_extension.dart';
import 'category_extension.dart';
import '../../generated/l10n.dart';
import '../enums/category_type.dart';
import '../widgets/custom_text.dart';
import 'package:flutter/material.dart';
import '../enums/date_filter_type.dart';
import 'number_formatting_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../features/categories/data/models/category_model.dart';
import '../../features/transactions/data/model/transaction_model.dart';

extension SearchExtension on List<TransactionModel> {
  /// Searches transactions by notes or category name.
  List<TransactionModel> search({required String query}) {
    final normalizedQuery = query.trim().toLowerCase();

    if (normalizedQuery.isEmpty) {
      return List<TransactionModel>.from(this);
    }

    return where((transaction) {
      final notes = transaction.notes.toLowerCase();
      final categoryName = transaction.categoryId
          .getCategory()
          .name
          .toLowerCase();

      return notes.contains(normalizedQuery) ||
          categoryName.contains(normalizedQuery);
    }).toList();
  }

  /// Filters transactions by category type and selected categories.
  List<TransactionModel> filter({
    required CategoriesType type,
    required DateFilterType dateFilterType,
    List<CategoryModel> categories = const [],
  }) {
    return where((transaction) {
      final category = transaction.categoryId.getCategory();
      final matchesType = switch (type) {
        CategoriesType.all => true,
        CategoriesType.income => category.isIncome,
        CategoriesType.expense => !category.isIncome,
      };
      final matchesCategory =
          categories.isEmpty || categories.contains(category);
      return matchesType && matchesCategory;
    }).toList().filterByDate(type: dateFilterType);
  }

  /// Filters transactions by date filter type.
  List<TransactionModel> filterByDate({
    required DateFilterType type,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return where((transaction) {
      final date = transaction.createdAt;
      return switch (type) {
        DateFilterType.day => date.isToday,
        DateFilterType.yesterday => date.isYesterday,
        DateFilterType.week => date.isInCurrentWeek,
        DateFilterType.month => date.isInCurrentMonth,
        DateFilterType.year => date.isInCurrentYear,
      };
    }).toList();
  }

  /// Returns the latest transactions.
  List<TransactionModel> getLastTransactions({int limit = 5}) {
    if (limit <= 0) {
      return [];
    }
    return take(limit).toList();
  }

  List<CategoryModel> getCategories({
    CategoriesType type = CategoriesType.all,
  }) {
    final categories = map(
      (transaction) => transaction.categoryId.getCategory(),
    ).toSet();

    return categories.where((category) {
      return switch (type) {
        CategoriesType.all => true,
        CategoriesType.income => category.isIncome,
        CategoriesType.expense => !category.isIncome,
      };
    }).toList();
  }
}

extension TransactionModelExtension on TransactionModel {
  // Gets the category associated with the transaction.
  CategoryModel getCategory() {
    return categoryId.getCategory();
  }

  // Gets the formatted amount with a sign based on whether it's income or expense.
  Widget getAmount(BuildContext context) {
    var color = isIncome ? Color(0xFF4CAF50) : Color(0xFFF44336);
    return CustomText(
      text: amount.moneyFormatWithSign(context: context, isIncome: isIncome),
      size: 18.sp,
      color: color,
      height: 1.4.h,
      type: Type.header,
    );
  }

  // Get Localized Type of Transaction
  Widget getLocalizedType(BuildContext context) {
    var s = S.of(context);
    var type = isIncome ? s.income : s.expense;
    return CustomText(
      text: type,
      size: 14.sp,
      height: 1.5.h,
      type: Type.header,
      opacity: FontOpacity.medium,
    );
  }
}

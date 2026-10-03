import '../../generated/l10n.dart';
import '../enums/category_type.dart';
import 'package:flutter/material.dart';

extension CategoriesTypeExtension on CategoriesType {
  String toLocalization({required BuildContext context}) {
    switch (this) {
      case CategoriesType.all:
        return S.of(context).all;
      case CategoriesType.income:
        return S.of(context).income;
      case CategoriesType.expense:
        return S.of(context).expense;
    }
  }
}

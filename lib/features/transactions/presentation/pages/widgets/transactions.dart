import 'package:flutter/material.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../const/app_data.dart';
import '../../../../../core/utils/nav_to.dart';
import '../views/add_edit_transaction_view.dart';
import '../../../data/model/transaction_model.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/custom_list.dart';
import '../../../../../core/extensions/date_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/custom_category_icon.dart';
import '../../../../../core/extensions/category_extension.dart';
import '../../../../categories/data/models/category_model.dart';
import '../../../../../core/extensions/number_formatting_extension.dart';

class Transactions extends StatelessWidget {
  final bool isLoading;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? scrollPhysics;
  final List<TransactionModel> transactions;
  const Transactions({
    super.key,
    this.padding,
    required this.isLoading,
    required this.transactions,
    this.scrollPhysics,
  });

  @override
  Widget build(BuildContext context) {
    return CustomList(
      padding: padding,
      items: transactions,
      isLoading: isLoading,
      scrollPhysics: scrollPhysics,
      itemBuilder: (transaction) => _Item(transaction: transaction),
    );
  }
}

class _Item extends StatelessWidget {
  final TransactionModel transaction;
  const _Item({required this.transaction});

  @override
  Widget build(BuildContext context) {
    var category = transaction.categoryId.getCategory();
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: defaultBoxShadow,
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.h),
      ),
      child: ListTile(
        minTileHeight: 60.h,
        minVerticalPadding: 0,
        horizontalTitleGap: 12.w,
        leading: _Leading(category: category),
        trailing: _Amount(transaction: transaction),
        subtitle: _SubTitle(transaction: transaction),
        title: _Title(transaction: transaction, category: category),
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        onTap: () => NavTo.push(
          context: context,
          nextPage: AddEditTransactionView(
            isIncome: transaction.isIncome,
            transaction: transaction,
          ),
        ),
      ),
    );
  }
}

class _Leading extends StatelessWidget {
  final CategoryModel category;
  const _Leading({required this.category});

  @override
  Widget build(BuildContext context) {
    return CustomCategoryIcon(category: category);
  }
}

class _Title extends StatelessWidget {
  final CategoryModel category;
  final TransactionModel transaction;
  const _Title({required this.transaction, required this.category});

  @override
  Widget build(BuildContext context) {
    var title = transaction.notes.isNotEmpty
        ? transaction.notes
        : category.name;
    return CustomText(text: title, size: 17.sp, height: 1.3, type: Type.header);
  }
}

class _SubTitle extends StatelessWidget {
  final TransactionModel transaction;
  const _SubTitle({required this.transaction});

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    return CustomText(
      text: transaction.createdAt.smartDate(
        locale: Localizations.localeOf(context).languageCode,
        nowText: s.now,
        yesterdayText: s.yesterday,
      ),
      height: 2.h,
      size: 14.sp,
      type: Type.header,
      opacity: FontOpacity.medium,
    );
  }
}

class _Amount extends StatelessWidget {
  final TransactionModel transaction;
  const _Amount({required this.transaction});

  @override
  Widget build(BuildContext context) {
    var sign = transaction.isIncome ? '+' : '-';
    var color = transaction.isIncome ? Color(0xFF4CAF50) : Color(0xFFF44336);
    return CustomText(
      text: "$sign \$${transaction.amount.moneyFormat}",
      size: 18.sp,
      color: color,
      type: Type.header,
    );
  }
}

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
import '../../../../../core/extensions/transaction_extension.dart';

class Transactions extends StatelessWidget {
  final bool isLoading;
  final double? itemSperator;
  final double? categoryIconSize;
  final bool? isCircleCategoryIcon;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? scrollPhysics;
  final EdgeInsetsGeometry? itemPadding;
  final List<TransactionModel> transactions;
  const Transactions({
    super.key,
    this.padding,
    this.itemPadding,
    this.itemSperator,
    this.scrollPhysics,
    this.categoryIconSize,
    required this.isLoading,
    this.isCircleCategoryIcon,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    return CustomList(
      padding: padding,
      items: transactions,
      isLoading: isLoading,
      scrollPhysics: scrollPhysics,
      itemSperator: itemSperator ?? 10,
      itemBuilder: (transaction) => _Item(
        itemPadding: itemPadding,
        transaction: transaction,
        categoryIconSize: categoryIconSize,
        isCircleCategoryIcon: isCircleCategoryIcon,
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final double? categoryIconSize;
  final bool? isCircleCategoryIcon;
  final TransactionModel transaction;
  final EdgeInsetsGeometry? itemPadding;
  const _Item({
    this.itemPadding,
    this.categoryIconSize,
    required this.transaction,
    this.isCircleCategoryIcon,
  });

  @override
  Widget build(BuildContext context) {
    var category = transaction.categoryId.getCategory();
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: defaultBoxShadow(),
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.h),
      ),
      child: ListTile(
        minTileHeight: 60.h,
        minVerticalPadding: 0,
        horizontalTitleGap: 12.w,
        leading: CustomCategoryIcon(
          category: category,
          size: categoryIconSize ?? 45,
          isCircle: isCircleCategoryIcon ?? true,
        ),
        title: _Title(category: category),
        trailing: transaction.getAmount(context),
        subtitle: _Time(transaction: transaction),
        contentPadding:
            itemPadding ??
            EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        onTap: () => NavTo.push(
          context: context,
          nextPage: AddEditTransactionView(
            isEdit: true,
            transaction: transaction,
            isIncome: transaction.isIncome,
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final CategoryModel category;
  const _Title({required this.category});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: category.name,
      height: 1.4.h,
      size: 16.sp,
      type: Type.header,
    );
  }
}

class _Time extends StatelessWidget {
  final TransactionModel transaction;
  const _Time({required this.transaction});

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    return CustomText(
      text: transaction.createdAt.smartDate(
        locale: Localizations.localeOf(context).languageCode,
        nowText: s.now,
        yesterdayText: s.yesterday,
      ),
      size: 14.sp,
      height: 1.5.h,
      type: Type.header,
      opacity: FontOpacity.medium,
    );
  }
}

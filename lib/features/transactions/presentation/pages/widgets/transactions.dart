import 'package:flutter/material.dart';
import '../../../../../generated/l10n.dart';
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
  final List<TransactionModel> transactions;
  const Transactions({
    super.key,
    required this.isLoading,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    return CustomList(
      isLoading: isLoading,
      items: transactions,
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
    return GestureDetector(
      onTap: () => NavTo.push(
        context: context,
        nextPage: AddEditTransactionView(
          isEdit: true,
          isIncome: transaction.isIncome,
          transaction: transaction,
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(20),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          spacing: 12.w,
          children: [
            Transform.translate(
              offset: Offset(0, 1.h),
              child: _Leading(category: category),
            ),
            _Body(category: category, transaction: transaction),
          ],
        ),
      )
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

class _Body extends StatelessWidget {
  final CategoryModel category;
  final TransactionModel transaction;
  const _Body({required this.category, required this.transaction});

  @override
  Widget build(BuildContext context) {
    var subTitle = transaction.notes.isNotEmpty
        ? transaction.notes
        : category.name;
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: _Title(title: category.name)),
              _Amount(transaction: transaction),
            ],
          ),
          Row(
            children: [
              Expanded(child: _SubTitle(subTitle: subTitle)),
              _Time(transaction: transaction),
            ],
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String title;
  const _Title({required this.title});

  @override
  Widget build(BuildContext context) {
    return CustomText(text: title, size: 17.sp, height: 1.3, type: Type.header);
  }
}

class _SubTitle extends StatelessWidget {
  final String subTitle;
  const _SubTitle({required this.subTitle});
  @override
  Widget build(BuildContext context) {
    return CustomText(
      size: 14.sp,
      height: 1.3,
      text: subTitle,
      type: Type.overMedium,
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
      text: "$sign ${transaction.amount.moneyFormat}",
      size: 17.sp,
      height: 1.3,
      color: color,
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
      height: 1.3,
      type: Type.header,
      opacity: FontOpacity.medium,
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../../const/app_data.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../data/model/report_transaction_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/number_formatting_extension.dart';

class AnalysisCard extends StatelessWidget {
  final String title;
  final double total;
  final bool isLoading;
  final List<ReportTransactionModel> transactions;
  const AnalysisCard({
    super.key,
    required this.title,
    required this.total,
    required this.isLoading,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        boxShadow: defaultBoxShadow(),
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.h),
      ),
      child: Column(
        spacing: 10.h,
        children: [
          _Top(title: title, total: total),
          _Bar(total: total, isLoading: isLoading, transactions: transactions),
          _Items(total: total, transactions: transactions),
        ],
      ),
    );
  }
}

class _Top extends StatelessWidget {
  final String title;
  final double total;
  const _Top({required this.title, required this.total});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomText(text: title, size: 16.5.sp, type: Type.overMedium),
        Spacer(),
        CustomText(
          text: total.moneyFormat(context: context),
          size: 15.5.sp,
          type: Type.header,
          opacity: FontOpacity.medium,
        ),
      ],
    );
  }
}

class _Bar extends StatelessWidget {
  final double total;
  final bool isLoading;
  final List<ReportTransactionModel> transactions;
  const _Bar({
    required this.total,
    required this.isLoading,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: SizedBox(
          height: 16.h,
          child: Row(
            spacing: 2.w,
            children: [
              for (final transaction in transactions)
                Expanded(
                  flex: (transaction.amount / total * 1000).round() + 15,
                  child: Container(color: Color(transaction.color)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Items extends StatelessWidget {
  final double total;
  final List<ReportTransactionModel> transactions;
  const _Items({required this.total, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5.h,
      children: transactions.map((transaction) {
        return _Item(total: total, transaction: transaction);
      }).toList(),
    );
  }
}

class _Item extends StatelessWidget {
  final double total;
  final ReportTransactionModel transaction;
  const _Item({required this.transaction, required this.total});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20.w,
          height: 20.h,
          decoration: BoxDecoration(
            color: Color(transaction.color),
            borderRadius: BorderRadius.circular(5.r),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: CustomText(
            size: 14.sp,
            type: Type.header,
            text: transaction.title,
          ),
        ),
        CustomText(
          size: 14.sp,
          type: Type.header,
          opacity: FontOpacity.medium,
          text: '${(transaction.amount / total * 100).toStringAsFixed(1)}%',
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.17,
          child: CustomText(
            size: 16.sp,
            type: Type.header,
            textAlign: TextAlign.end,
            text: transaction.amount.moneyFormat(context: context),
          ),
        ),
      ],
    );
  }
}

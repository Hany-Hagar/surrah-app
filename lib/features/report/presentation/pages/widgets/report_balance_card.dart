import 'package:flutter/material.dart';
import '../../../../../const/app_data.dart';
import '../../../../../core/utils/theme.dart';
import '../../../data/model/report_model.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../core/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/number_formatting_extension.dart';

class ReportBalanceCard extends StatelessWidget {
  final bool isLoading;
  final ReportModel data;
  const ReportBalanceCard({
    super.key,
    required this.isLoading,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          boxShadow: defaultBoxShadow(),
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(12.h),
        ),
        child: Column(
          children: [
            _NetBalance(netBalance: data.totalIncome - data.totalExpense),
            _Items(data: data),
          ],
        ),
      ),
    );
  }
}

class _NetBalance extends StatelessWidget {
  final double netBalance;
  const _NetBalance({required this.netBalance});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: double.infinity),
        CustomText(
          text: 'NETBALANCE',
          size: 11.sp,
          height: 1.3,
          type: Type.header,
          color: Colors.white,
          opacity: FontOpacity.overMedium,
        ),
        CustomText(
          text: netBalance.moneyFormat(context: context),
          size: 33.sp,
          type: Type.header,
          color: Colors.white,
        ),
      ],
    );
  }
}

class _Items extends StatelessWidget {
  final ReportModel data;
  const _Items({required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _Item(title: 'Income', value: data.totalIncome, color: AppTheme.income),
        _Divider(),
        _Item(
          title: 'Expense',
          value: data.totalExpense,
          color: AppTheme.expense,
        ),
        _Divider(),
        _Item(
          flex: 3,
          title: 'Saved',
          percentage: (data.totalIncome - data.totalExpense).getPercentage(
            total: data.totalIncome,
          ),
          color: Colors.white,
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(end: 10.w),
      width: 1.w,
      height: 30.h,
      color: Theme.of(context).dividerColor,
    );
  }
}

class _Item extends StatelessWidget {
  final String title;
  final double? value;
  final String? percentage;
  final Color color;
  final int flex;
  const _Item({
    this.value,
    this.percentage,
    required this.title,
    required this.color,
    this.flex = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: title,
            height: 1.3,
            size: 11.5.sp,
            type: Type.overMedium,
            color: Colors.white,
          ),
          CustomText(
            size: 19.sp,
            color: color,
            type: Type.header,
            text: percentage ?? value!.moneyFormat(context: context),
          ),
        ],
      ),
    );
  }
}

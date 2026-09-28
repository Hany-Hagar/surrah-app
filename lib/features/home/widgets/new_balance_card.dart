import '../../../const/assets.dart';
import '../../../const/app_data.dart';
import '../../../generated/l10n.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/theme.dart';
import '../../../core/widgets/custom_text.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../transactions/data/model/balance_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/extensions/number_formatting_extension.dart';

class NewBalanceCard extends StatelessWidget {
  final BalanceModel currentBalance;
  const NewBalanceCard({super.key, required this.currentBalance});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        boxShadow: defaultBoxShadow(),
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(12.r),
        image: const DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(Assets.balanceCardBackground),
        ),
      ),
      child: Column(
        spacing: 12.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Current(balance: currentBalance),
          _Items(balance: currentBalance),
        ],
      ),
    );
  }
}

class _Current extends StatelessWidget {
  final BalanceModel balance;
  const _Current({required this.balance});

  @override
  Widget build(BuildContext context) {
    var color= Colors.black;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          size: 15.sp,
          color: color,
          height: 1.3.h,
          type: Type.header,
          opacity: FontOpacity.overMedium,
          text: S.of(context).currentBalance,
        ),
        CustomText(
          size: 24.sp,
          color: color,
          height: 1.2.h,
          type: Type.header,
          text: balance.balance.moneyFormat(context: context),
        ),
      ],
    );
  }
}

class _Items extends StatelessWidget {
  final BalanceModel balance;
  const _Items({required this.balance});

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    return Row(
      spacing: 10.w,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _Item(
          icon: PhosphorIconsDuotone.trendUp,
          title: s.income,
          amount: balance.totalIncome,
          color: AppTheme.income,
        ),
        _Item(
          icon: PhosphorIconsDuotone.trendDown,
          title: s.expense,
          amount: balance.totalExpense,
          color: AppTheme.expense,
        ),
      ],
    );
  }
}

class _Item extends StatelessWidget {
  final IconData icon;
  final String title;
  final double amount;
  final Color color;
  const _Item({
    required this.icon,
    required this.title,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 68.h,
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: 12.w,
          vertical: 8.h,
        ).copyWith(end: 6.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Row(
          spacing: 10.h,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: Center(
                child: Icon(icon, color: Colors.white, size: 22.sp),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: title,
                    size: 14.sp,
                    height: 1.4.h,
                    type: Type.header,
                    opacity: FontOpacity.overMedium,
                  ),
                  CustomText(
                    size: 17.sp,
                    height: 1.4.h,
                    type: Type.header,
                    text: "1234567891",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

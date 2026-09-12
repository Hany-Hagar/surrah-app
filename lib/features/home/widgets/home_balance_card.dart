import '../../../generated/l10n.dart';
import 'package:flutter/material.dart';
import '../../../core/widgets/custom_text.dart';
import '../../transactions/data/model/balance_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeBalanceCard extends StatelessWidget {
  final BalanceModel currentBalance;
  const HomeBalanceCard({super.key, required this.currentBalance});

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          _Top(currentBalance: currentBalance),
          Padding(
            padding: EdgeInsets.all(8.w).copyWith(top: 5.h),
            child: Row(
              spacing: 3.w,
              mainAxisSize: MainAxisSize.min,
              children: [
                _BalanceItem(
                  color: Colors.green,
                  title: s.income,
                  icon: Icons.arrow_downward,
                  amount: currentBalance.totalIncome,
                ),
                SizedBox(width: 5.w),
                _BalanceItem(
                  color: Colors.red,
                  title: s.expense,
                  icon: Icons.arrow_upward,
                  amount: currentBalance.totalExpense,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Top extends StatelessWidget {
  final BalanceModel currentBalance;
  const _Top({required this.currentBalance});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TopBody(currentBalance: currentBalance.balance),
        SizedBox(
          width: 80.w,
          height: 80.w,
          child: _Progress(size: 28, progress: currentBalance.percentage),
        ),
      ],
    );
  }
}

class _TopBody extends StatelessWidget {
  final double currentBalance;
  const _TopBody({required this.currentBalance});

  @override
  Widget build(BuildContext context) {
    var color = Colors.white;
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: S.of(context).currentBalance,
              size: 14.sp,
              color: color,
              type: Type.overMedium,
              opacity: FontOpacity.overMedium,
            ),
            CustomText(
              text: currentBalance.toStringAsFixed(2),
              size: 20.sp,
              color: color,
              type: Type.overMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _Progress extends StatelessWidget {
  final double progress;
  final double size;
  const _Progress({required this.size, required this.progress});

  @override
  Widget build(BuildContext context) {
    const color = Colors.grey;
    const backgroundColor = Colors.green;
    final remaining = 1 - progress;
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: (size - 18).r,
          backgroundColor: backgroundColor.withAlpha(100),
        ),
        // Outer circle
        CircularProgressIndicator(
          value: progress,
          strokeWidth: size.r,
          strokeAlign: 0,
          color: color.withAlpha(100),
          backgroundColor: backgroundColor.withAlpha(80),
        ),

        // Inner circle
        CircularProgressIndicator(
          value: progress,
          strokeWidth: (size - 18).r,
          strokeAlign: 0,
          color: color.withAlpha(100),
          backgroundColor: backgroundColor.withAlpha(100),
        ),

        CustomText(
          text: formatProgress(remaining),
          size: 14.sp,
          type: Type.overMedium,
          color: Colors.white,
        ),
      ],
    );
  }

  String formatProgress(double progress) {
    final value = progress * 100;
    final rounded = value.roundToDouble();

    if ((value - rounded).abs() < 0.01) {
      return '${rounded.toInt()}%';
    }

    return '${value.toStringAsFixed(2)} %';
  }
}

class _BalanceItem extends StatelessWidget {
  final Color color;
  final String title;
  final IconData icon;
  final double amount;
  const _BalanceItem({
    required this.color,
    required this.title,
    required this.icon,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: color.withAlpha(50),
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(color: color.withAlpha(50), width: 1.w),
        ),
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: 8.w,
              ).copyWith(start: 10.w),
              child: CircleAvatar(
                radius: 17.r,
                backgroundColor: color,
                child: Icon(icon, color: Colors.white, size: 20.sp),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: title,
                    size: 14.sp,
                    type: Type.overMedium,
                    color: Colors.white,
                  ),
                  CustomText(
                    text: amount.toStringAsFixed(2),
                    size: 14.sp,
                    type: Type.overMedium,
                    color: Colors.white,
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

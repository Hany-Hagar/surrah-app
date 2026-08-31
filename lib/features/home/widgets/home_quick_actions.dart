import 'dart:developer';
import '../../../generated/l10n.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/nav_to.dart';
import 'package:icon_broken/icon_broken.dart';
import '../../../core/services/dialog_service.dart';
import 'package:surrah/core/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../categories/presentation/pages/widgets/add_edit_category.dart';
import '../../transactions/presentation/pages/views/add_edit_transaction_view.dart';

class HomeQuickActions extends StatelessWidget {
  const HomeQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: s.quickActions, size: 18.sp, type: Type.overMedium),
        SizedBox(height: 10.h),
        Row(
          spacing: 5.w,
          children: [
            _Item(
              color: Colors.green,
              title: s.addIncome,
              icon: IconBroken.Wallet,
              onPressed: () {
                NavTo.push(
                  context: context,
                  nextPage: const AddEditTransactionView(isIncome: true),
                );
              },
            ),
            _Item(
              color: Colors.red,
              title: s.addExpense,
              icon: IconBroken.Send,
              onPressed: () {
                NavTo.push(
                  context: context,
                  nextPage: const AddEditTransactionView(isIncome: false),
                );
              },
            ),
            _Item(
              color: Colors.orange,
              title: s.addCategory,
              icon: IconBroken.Category,
              onPressed: () {
                log('Add Category pressed');
                DialogService.showCustomDialog(
                  context: context,
                  body: const AddEditCategory(),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _Item extends StatelessWidget {
  final Color color;
  final String title;
  final IconData icon;
  final VoidCallback onPressed;
  const _Item({
    required this.color,
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: color.withAlpha(50),
            borderRadius: BorderRadius.circular(4.r),
            border: Border.all(color: color.withAlpha(50), width: 1.w),
          ),
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 17.r,
                backgroundColor: color,
                child: Icon(icon, color: Colors.white, size: 20.sp),
              ),
              SizedBox(height: 6.h),
              CustomText(text: title, size: 14.sp, type: Type.overMedium),
            ],
          ),
        ),
      ),
    );
  }
}

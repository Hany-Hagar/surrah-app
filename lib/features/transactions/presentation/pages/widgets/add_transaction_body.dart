import 'add_transaction_card.dart';
import 'package:flutter/material.dart';
import '../../../../../generated/l10n.dart';
import 'package:icon_broken/icon_broken.dart';
import '../../../../../core/utils/styles.dart';
import '../../manager/transactions_cubit.dart';
import '../../manager/transactions_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/custom_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/date_extension.dart';
import '../../../../../core/widgets/custom_category_icon.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';

class AddTransactionBody extends StatelessWidget {
  final bool isIncome;
  const AddTransactionBody({super.key, required this.isIncome});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    return BlocBuilder<TransactionsCubit, TransactionsStates>(
      builder: (context, state) => Column(
        spacing: 14.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Form(
            key: formKey,
            autovalidateMode: TransactionsCubit.get(context).autoValidateMode,
            child: _Amount(),
          ),
          _Category(),
          _Time(),
          _Notes(),
          Spacer(),
          _Button(
            formKey: formKey,
            isIncome: isIncome,
            isLoading: state is AddTransactionLoading,
          ),
        ],
      ),
    );
  }
}

class _Amount extends StatelessWidget {
  const _Amount();

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    var cubit = TransactionsCubit.get(context);

    return AddTransactionCard(
      bodySpacing: 0,
      title: s.addTransactionAmountTitle,
      icon: IconBroken.Wallet,
      itemsAlignment: CrossAxisAlignment.center,
      body: CustomText(text: s.addTransactionAmountTypeHint, size: 16.sp),
      trailing: Expanded(
        child: CustomTextFormField(
          hintText: '0.00',
          border: InputBorder.none,
          textAlign: TextAlign.end,
          keyboardType: TextInputType.number,
          controller: cubit.amountController,
          backgroundColor: Theme.of(context).cardColor,
          hintStyle: _styles(context: context, fontSize: 26),
          inputStyle: _styles(context: context, fontSize: 24),
          padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 10.h),
        ),
      ),
    );
  }

  TextStyle _styles({
    required BuildContext context,
    required double fontSize,
  }) => Styles.textStyle800.copyWith(
    color: Theme.of(context).hintColor,
    fontSize: fontSize.sp,
  );
}

class _Category extends StatelessWidget {
  const _Category();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var cubit = TransactionsCubit.get(context);
    var category = cubit.selectedCategory;
    var s = S.of(context);
    return AddTransactionCard(
      icon: IconBroken.Category,
      title: s.addTransactionCategoryTitle,
      body: GestureDetector(
        onTap: () => cubit.updateSelectedCategory(context: context),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(4.r),
            border: Border.all(color: theme.hintColor.withValues(alpha: .5)),
          ),
          child: Row(
            spacing: 10.w,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomCategoryIcon(size: 30, category: category),
              Expanded(
                child: CustomText(
                  text: category.name,
                  size: 16.sp,
                  type: Type.overMedium,
                ),
              ),
              Icon(
                size: 22.sp,
                Icons.arrow_forward_ios,
                color: theme.colorScheme.secondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Time extends StatelessWidget {
  const _Time();

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    var cubit = TransactionsCubit.get(context);
    return AddTransactionCard(
      icon: IconBroken.Calendar,
      title: s.addTransactionDate,
      body: CustomTextFormField(
        readOnly: true,
        prefixIcon: IconBroken.Calendar,
        keyboardType: TextInputType.datetime,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        controller: TextEditingController(
          text: cubit.selectedDate.fullWithTime,
        ),
      ),
    );
  }
}

class _Notes extends StatelessWidget {
  const _Notes();

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    var cubit = TransactionsCubit.get(context);
    return AddTransactionCard(
      title: s.addTransactionNotes,
      icon: IconBroken.Document,
      body: CustomTextFormField(
        maxAutoLines: 3,
        autoMaxLines: true,
        prefixIcon: IconBroken.Paper,
        controller: cubit.notesController,
        hintText: s.addTransactionNotesHint,
        keyboardType: TextInputType.multiline,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final bool isIncome;
  final bool isLoading;
  final GlobalKey<FormState> formKey;
  const _Button({
    required this.isIncome,
    required this.isLoading,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    var cubit = TransactionsCubit.get(context);
    return CustomButton(
      isLoading: isLoading,
      text: s.addTransactionButton,
      onPressed: () =>
          cubit.addTransaction(formKey: formKey, isIncome: isIncome),
    );
  }
}

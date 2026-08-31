import 'package:flutter/material.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/transactions_cubit.dart';
import '../../../../../core/utils/nav_to.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../manager/transactions_states.dart';
import '../widgets/add_edit_transaction_body.dart';
import '../../../data/model/transaction_model.dart';
import '../../../../../core/di/server_locator.dart';
import '../../../../../core/widgets/custom_back.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../core/widgets/custom_scaffold.dart';
import '../../../../../core/services/snack_bar_service.dart';

class AddEditTransactionView extends StatelessWidget {
  final bool isEdit;
  final bool isIncome;
  final TransactionModel? transaction;
  const AddEditTransactionView({
    super.key,
    this.isEdit = false,
    required this.isIncome,
    this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    return BlocProvider.value(
      value: getIt<TransactionsCubit>()
        ..initalData(
          isEdit: isEdit,
          isIncome: isIncome,
          transaction: transaction,
        ),
      child: BlocListener<TransactionsCubit, TransactionsStates>(
        listener: (context, state) {
          if (state is AddTransactionSuccess) {
            NavTo.pop(context);
            SnackBarService.success(
              context: context,
              message: s.addTransactionSuccess,
            );
          }
          if (state is AddTransactionFailure) {
            SnackBarService.failure(
              context: context,
              message: s.addTransactionFailure,
            );
          }
          if (state is UpdateTransactionSuccess) {
            NavTo.pop(context);
            SnackBarService.success(
              context: context,
              message: s.updateTransactionSuccess,
            );
          }
          if (state is UpdateTransactionFailure) {
            SnackBarService.failure(
              context: context,
              message: s.updateTransactionFailure,
            );
          }
        },
        child: CustomScaffold(
          appBar: CustomAppBar(
            leading: CustomBack(),
            title: isEdit ? s.updateTransactionTitle : s.addTransactionTitle,
            subtitle: isEdit
                ? s.updateTransactionSubtitle
                : s.addTransactionSubtitle,
          ),
          body: AddEditTransactionBody(isIncome: isIncome, isEdit: isEdit),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../../generated/l10n.dart';
import '../widgets/add_transaction_body.dart';
import '../../manager/transactions_cubit.dart';
import '../../../../../core/utils/nav_to.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../manager/transactions_states.dart';
import '../../../../../core/di/server_locator.dart';
import '../../../../../core/widgets/custom_back.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../core/widgets/custom_scaffold.dart';
import '../../../../../core/services/snack_bar_service.dart';

class AddTransactionView extends StatelessWidget {
  final bool isIncome;
  const AddTransactionView({super.key, required this.isIncome});

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    return BlocProvider.value(
      value: getIt<TransactionsCubit>()..initalData(isIncome: isIncome),
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
        },
        child: CustomScaffold(
          appBar: CustomAppBar(
            leading: CustomBack(),
            title: s.addTransactionTitle,
            subtitle: s.addTransactionSubtitle,
          ),
          body: AddTransactionBody(isIncome: isIncome),
        ),
      ),
    );
  }
}

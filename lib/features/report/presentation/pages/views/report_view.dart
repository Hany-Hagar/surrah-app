import '../widgets/report_body.dart';
import 'package:flutter/material.dart';
import '../../manager/report_cubit.dart';
import '../../../../../generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/widgets/custom_back.dart';
import 'package:surrah/core/widgets/custom_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../transactions/data/model/balance_model.dart';
import '../../../../transactions/data/model/transaction_model.dart';

class ReportView extends StatelessWidget {
  final BalanceModel currentBalance;
  final List<TransactionModel> transactions;
  const ReportView({
    super.key,
    required this.currentBalance,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    return BlocProvider(
      create: (context) => ReportCubit()
        ..initReport(
          currentBalance: currentBalance,
          transactions: transactions,
        ),
      child: Scaffold(
        appBar: CustomAppBar(
          leading: CustomBack(),
          title: s.reportTitle,
          subtitle: s.reportSubtitle,
        ),
        body: SingleChildScrollView(
          child: Padding(padding: EdgeInsets.all(12.w), child: ReportBody()),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../manager/report_cubit.dart';
import '../../../../../core/widgets/balance_card.dart';

class ReportBody extends StatelessWidget {
  const ReportBody({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = ReportCubit.get(context);
    return Column(
      children: [
        BalanceCard(
          showButton: false,
          title: "صافي الرصيد",
          currentBalance: cubit.reportModel.balance,
          transactions: cubit.reportModel.transactions,
          trailing: SizedBox(),
        ),
      ],
    );
  }
}

// import 'report_analysis_card.dart';
// import 'package:flutter/material.dart';
// import '../../manager/report_cubit.dart';
// import '../../manager/report_states.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../../core/widgets/empty_view.dart';
// import '../../../../../core/widgets/custom_text.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../../transactions/data/model/transaction_model.dart';
// import '../../../../transactions/presentation/pages/widgets/transactions.dart';

// class ReportBody extends StatelessWidget {
//   const ReportBody({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ReportCubit, ReportStates>(
//       builder: (context, state) {
//         var report = ReportCubit.get(context).reportModel;
//         return report.transactions.isEmpty
//             ?  EmptyView()
//             : Column(
//                 spacing: 12.h,
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ReportAnalysisCard(reportModel: report),
//                   _List(
//                     title: "Income",
//                     transactions: report.incomeTransactions,
//                   ),
//                   _List(
//                     title: "Expense",
//                     transactions: report.expenseTransactions,
//                   ),
//                 ],
//               );
//       },
//     );
//   }
// }

// class _List extends StatelessWidget {
//   final String title;
//   final List<TransactionModel> transactions;
//   const _List({this.title = "", this.transactions = const []});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       spacing: 12.h,
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         CustomText(text: title, size: 18.sp, type: Type.header),
//         Transactions(
//           isLoading: false,
//           padding: EdgeInsets.zero,
//           transactions: transactions,
//           scrollPhysics: const NeverScrollableScrollPhysics(),
//         ),
//       ],
//     );
//   }
// }

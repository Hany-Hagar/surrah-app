// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart' hide Action;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:surrah/features/report/presentation/manager/report_cubit.dart';
import 'package:surrah/features/report/presentation/pages/widgets/report_body_view.dart';
import '../../../../../core/di/server_locator.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../core/widgets/custom_scaffold.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/report_state.dart';

class ReportView extends StatelessWidget {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ReportCubit>(),
      child: CustomScaffold(
        appBar: CustomAppBar(
          title: S.of(context).report,
          subtitle: S.of(context).reportSubtitle,
          actions: [
            Action(
              icon: IconBroken.Calendar,
              onPressed: () {
                // Implement your action here
                final currentState = context.read<ReportCubit>().state;
                final currentMonth = currentState is ReportMonthSelected
                    ? currentState.selectedMonth
                    : DateTime.now();
                    
              },
            ),
          ],
        ),
        body: const ReportBodyView(),
      ),
    );
  }
}

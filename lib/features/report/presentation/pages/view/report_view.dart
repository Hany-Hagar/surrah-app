import 'package:flutter/material.dart' hide Action;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:surrah/features/report/presentation/manager/report_cubit.dart';
import 'package:surrah/features/report/presentation/pages/widgets/report_body_view.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../core/widgets/custom_back.dart';
import '../../../../../core/widgets/custom_scaffold.dart';
import '../../../../../generated/l10n.dart';

class ReportView extends StatelessWidget {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportCubit(),
      child: CustomScaffold(
        appBar: CustomAppBar(
          title: S.of(context).report,
          leading: const CustomBack(),
          actions: [
            Action(
              icon: IconBroken.Calendar,
              onPressed: () {
                // Implement your action here
              },
            ),
          ],
        ),
        body: const ReportBodyView(),
      ),
    );
  }
}

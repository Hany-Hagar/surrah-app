import '../widgets/report_body.dart';
import 'package:flutter/material.dart';
import '../../manager/report_state.dart';
import '../../manager/report_cubit.dart';
import '../../../../../generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/di/server_locator.dart';
import '../../../../../core/widgets/custom_toggle.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../core/enums/date_filter_type.dart';
import '../../../../../core/extensions/date_filter_type_extensions.dart';

class ReportView extends StatelessWidget {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ReportCubit>()..fetchData(),
      child: Scaffold(
        appBar: CustomAppBar(
          bottom: const _Top(),
          title: S.of(context).reportTitle,
          subtitle: S.of(context).reportSubtitle,
        ),
        body: const SingleChildScrollView(child: ReportBody()),
      ),
    );
  }
}

class _Top extends StatelessWidget {
  const _Top();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportCubit, ReportStates>(
      builder: (context, state) {
        var cubit = ReportCubit.get(context);
        return CustomToggle<DateFilterType>(
          selectedItem: cubit.dateFilter,
          items: DateFilterType.values.reportValues,
          onChanged: (value) => cubit.fetchData(date: value),
          itemLabel: (value) => value.reportLabel(context: context),
        );
      },
    );
  }
}

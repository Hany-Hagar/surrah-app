import 'package:flutter/material.dart';
import '../../../../../generated/l10n.dart';
import '../widgets/home_widget_body.dart';
import '../../manager/home_widget_cubit.dart';
import '../../manager/home_widget_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/custom_back.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeWidgetView extends StatelessWidget {
  const HomeWidgetView({super.key});

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    return BlocProvider(
      create: (context) => HomeWidgetCubit(),
      child: Scaffold(
        appBar: CustomAppBar(
          leading: CustomBack(),
          title: s.homeWidgetTitle,
          subtitle: s.homeWidgetSubtitle,
        ),
        body:  Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.r),
          child: BlocBuilder<HomeWidgetCubit, HomeWidgetStates> (
            builder: (context, state) => HomeWidgetBody()
          )
        ),
      )
    );
  }
}

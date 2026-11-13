import 'new_setup_card.dart';
import 'new_ui_setup_card.dart';
import 'package:flutter/material.dart';
import '../../../core/di/server_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../setup/widgets/privacy_setup_card.dart';
import '../../../core/services/currency_services.dart';
import '../../settings/model/app_user_pref_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../settings/presentation/manager/settings_cubit.dart';

class NewSetupBody extends StatelessWidget {
  final PageController controller;
  final void Function(int) onPageChanged;
  const NewSetupBody({
    super.key,
    required this.controller,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      onPageChanged: onPageChanged,
      children: const [NewUiSetupCard(), _CurrencySetup(), PrivacySetupCard()],
    );
  }
}

class _CurrencySetup extends StatelessWidget {
  const _CurrencySetup();

  @override
  Widget build(BuildContext context) {
    return NewSetupCard(
      title: "اختار عملتك",
      subtitle:
          "اختار العملة اللي تحب تستخدمها في ضرّة. تقدر تغيّرها بعدين من الإعدادات.",
      avatar: Image.asset(
        "assets/images/currency.png",
        width: 100.w,
        height: 100.h,
      ),
      child: BlocBuilder<SettingsCubit, AppUserPref>(
        builder: (context, state) {
          var cubit = getIt<SettingsCubit>();
          return CurrencyServices.setup(
            context: context,
            padding: EdgeInsets.zero,
            currentCurrency: state.currency,
            onSelect: (currency) => cubit.setCurrency(currency),
          );
        },
      ),
    );
  }
}

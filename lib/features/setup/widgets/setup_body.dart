import 'ui_setup_card.dart';
import 'privacy_setup_card.dart';
import 'setup_card.dart';
import 'package:flutter/material.dart';
import '../../../core/di/server_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/currency_services.dart';
import '../../settings/model/app_user_pref_model.dart';
import '../../settings/presentation/manager/settings_cubit.dart';

class SetupBody extends StatelessWidget {
  final PageController controller;
  final void Function(int) onPageChanged;
  const SetupBody({
    super.key,
    required this.controller,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      onPageChanged: onPageChanged,
      children: const [UiSetupCard(), _CurrencySetup(), PrivacySetupCard()],
    );
  }
}

class _CurrencySetup extends StatelessWidget {
  const _CurrencySetup();

  @override
  Widget build(BuildContext context) {
    return SetupCard(
      title: "اختار عملتك",
      subtitle:
          "اختار العملة اللي تحب تستخدمها في ضرّة. تقدر تغيّرها بعدين من الإعدادات.",
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

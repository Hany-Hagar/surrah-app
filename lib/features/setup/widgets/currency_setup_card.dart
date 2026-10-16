import 'setup_card.dart';
import '../../../generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surrah/core/di/server_locator.dart';
import '../../settings/model/app_user_pref_model.dart';
import '../../../core/services/currency_services.dart';
import '../../settings/presentation/manager/settings_cubit.dart';

class CurrencySetupCard extends StatelessWidget {
  const CurrencySetupCard({super.key});

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    return SetupCard(
      title: s.currencySetupTitle,
      subtitle: s.currencySetupSubtitle,
      child: Expanded(
        child: _Body()
      )
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, AppUserPref>(
      builder: (context, state) {
        var cubit = getIt<SettingsCubit>();
        return CurrencyServices.setup(
          context: context,
          padding: EdgeInsets.zero,
          currentCurrency: state.currency,
          onSelect: (currency) => cubit.setCurrency(currency),
        );
      },
    );
  }
}

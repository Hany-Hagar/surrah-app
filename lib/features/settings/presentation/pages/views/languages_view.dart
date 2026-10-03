import 'package:flutter/material.dart';
import '../widgets/languages_body.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/widgets/custom_back.dart';
import '../../../../../core/widgets/custom_app_bar.dart';

class LanguagesView extends StatelessWidget {
  const LanguagesView({super.key});

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: s.languageTitle,
        subtitle: s.languageSubtitle,
        leading: CustomBack(),
      ),
      body: const LanguagesBody(),
    );
  }
}

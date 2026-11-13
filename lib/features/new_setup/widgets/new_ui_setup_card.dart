import 'new_setup_card.dart';
import 'package:flutter/material.dart';
import '../../../core/widgets/custom_themes.dart';

class NewUiSetupCard extends StatelessWidget {
  final double avatarSize;
  const NewUiSetupCard({super.key, this.avatarSize = 100});

  @override
  Widget build(BuildContext context) {
    return NewSetupCard(
      avatar: SizedBox(),
      title: "اختار المظهر",
      subtitle: "اختر المظهر الذي يناسبك",
      child: CustomThemes(),
    );
  }
}

import 'package:flutter/material.dart';

class CustomFloatingButton extends StatelessWidget {
  final IconData? icon;
  final bool isVisible;
  final VoidCallback? onPressed;
  const CustomFloatingButton({
    super.key,
    this.icon,
    this.isVisible = true,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return isVisible
        ? FloatingActionButton(
            onPressed: onPressed,
            backgroundColor: theme.colorScheme.secondary,
            child: Icon(
              icon ?? Icons.add,
              color: theme.scaffoldBackgroundColor,
            ),
          )
        : const SizedBox.shrink();
  }
}

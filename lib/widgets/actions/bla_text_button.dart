import 'package:flutter/material.dart';
import '../../theme/theme.dart';

/// A reusable text button for the application.
class BlaTextButton extends StatelessWidget {
  const BlaTextButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Text(
          text,
          style: BlaTextStyles.button.copyWith(color: BlaColors.primary),
        ),
      ),
    );
  }
}

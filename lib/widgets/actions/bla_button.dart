import 'package:flutter/material.dart';
import '../../theme/theme.dart';

enum ButtonType { primary, secondary }

/// Custom button for the entire application.
class BlaButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  final IconData? icon;

  const BlaButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = ButtonType.primary,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPrimary = type == ButtonType.primary;

    return SizedBox(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: isPrimary ? BlaColors.primary : BlaColors.white,
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BlaSpacings.radius),
          ),
          side: isPrimary
              ? BorderSide.none
              : BorderSide(color: BlaColors.greyLight, width: 2),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20, color: isPrimary ? BlaColors.white : BlaColors.primary),
              SizedBox(width: BlaSpacings.s),
            ],
            Text(
              text,
              style: BlaTextStyles.button.copyWith(
                color: isPrimary ? BlaColors.white : BlaColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

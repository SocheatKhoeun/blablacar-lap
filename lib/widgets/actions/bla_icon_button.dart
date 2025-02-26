import 'package:flutter/material.dart';
import '/theme/theme.dart';

/// A reusable icon button with hover effect.
class BlaIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const BlaIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Icon(icon, size: BlaSize.icon, color: BlaColors.primary),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '/widgets/actions/bla_icon_button.dart';
import '../../../theme/theme.dart';

/// A selectable tile for the Ride Preference screen.
class RidePrefInputTile extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final IconData leftIcon;
  final bool isPlaceHolder;
  final IconData? rightIcon;
  final VoidCallback? onRightIconPressed;

  const RidePrefInputTile({
    super.key,
    required this.title,
    required this.onPressed,
    required this.leftIcon,
    this.rightIcon,
    this.onRightIconPressed,
    this.isPlaceHolder = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      title: Text(
        title,
        style: BlaTextStyles.button.copyWith(
          fontSize: 14,
          color: isPlaceHolder ? BlaColors.textLight : BlaColors.textNormal,
        ),
      ),
      leading: Icon(
        leftIcon,
        size: BlaSize.icon,
        color: BlaColors.iconLight,
      ),
      trailing: rightIcon != null
          ? BlaIconButton(icon: rightIcon!, onPressed: onRightIconPressed)
          : null,
    );
  }
}

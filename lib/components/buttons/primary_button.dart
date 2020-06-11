import 'package:dicery/components/buttons/base_button.dart';
import 'package:flutter/material.dart';

class PrimaryDiceryButton extends DiceryIconButton {
  final VoidCallback onPressed;
  final String label;
  final IconData iconData;

  const PrimaryDiceryButton({
    this.onPressed,
    this.label,
    this.iconData,
  }) : super(
          onPressed: onPressed,
          label: label,
          iconData: iconData,
          backgroundColor: Colors.white,
          textColor: const Color(0xFF2B2D42),
          iconColor: const Color(0xFFef233c),
        );
}

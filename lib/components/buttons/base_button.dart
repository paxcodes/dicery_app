import 'package:flutter/material.dart';

class DiceryIconButton extends StatelessWidget {
  final String label;
  final Function onPressed;
  final IconData iconData;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;

  const DiceryIconButton(
      {this.label,
      this.onPressed,
      this.iconData,
      this.backgroundColor,
      this.textColor,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 275,
      child: RaisedButton.icon(
        color: backgroundColor,
        onPressed: onPressed,
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        icon: Icon(
          iconData,
          color: iconColor,
          size: 35,
        ),
        label: Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }
}

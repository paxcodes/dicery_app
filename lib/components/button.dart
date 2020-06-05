import 'package:flutter/material.dart';

class DiceryIconButton extends StatelessWidget {
  final String label;
  final Function onPressed;
  final IconData iconData;
  final bool isPrimary;

  DiceryIconButton(
      {this.isPrimary = true, this.label, this.onPressed, this.iconData});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 275,
      child: RaisedButton.icon(
        color: isPrimary ? Colors.teal.shade900 : Colors.teal.shade100,
        onPressed: onPressed,
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(28)),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        icon: Icon(
          iconData,
          color: isPrimary ? Colors.white : Colors.teal.shade900,
        ),
        label: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: isPrimary ? Colors.white : Colors.teal.shade900,
          ),
        ),
      ),
    );
  }
}

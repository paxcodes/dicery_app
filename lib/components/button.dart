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
        onPressed: onPressed,
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        icon: Icon(
          iconData,
        ),
        label: Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }
}

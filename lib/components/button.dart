import 'package:flutter/material.dart';

class DiceryIconButton extends StatelessWidget {
  final String label;
  final Function onPressed;
  final IconData iconData;

  DiceryIconButton({this.label, this.onPressed, this.iconData});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 275,
      child: RaisedButton.icon(
        color: Colors.teal.shade900,
        onPressed: onPressed,
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(28)),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        icon: Icon(
          iconData,
          color: Colors.white,
        ),
        label: Text(
          label,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

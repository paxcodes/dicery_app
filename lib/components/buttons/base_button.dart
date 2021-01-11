import 'package:flutter/material.dart';

class DiceryIconButton extends StatelessWidget {
  final String label;
  final Function onPressed;
  final IconData iconData;
  final Color _backgroundColor;
  final Color _textColor;
  final Color _iconColor;

  const DiceryIconButton({this.label, this.onPressed, this.iconData})
      : _backgroundColor = null,
        _textColor = null,
        _iconColor = null;

  const DiceryIconButton.primary({this.onPressed, this.label, this.iconData})
      : _backgroundColor = Colors.white,
        _textColor = const Color(0xFF2B2D42),
        _iconColor = const Color(0xFFef233c);

  @override
  Widget build(BuildContext context) {
    var finalIconColor = _iconColor;
    var finalTextColor = _textColor;
    if (onPressed == null) {
      finalIconColor = _iconColor.withOpacity(0.3);
      finalTextColor = _textColor.withOpacity(0.3);
    }

    return SizedBox(
      width: 275,
      child: RaisedButton.icon(
        disabledColor: Color(0xFFEFEFEF),
        color: _backgroundColor,
        onPressed: onPressed,
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        icon: Icon(
          iconData,
          color: finalIconColor,
          size: 35,
        ),
        label: Text(
          label,
          style: Theme.of(context).textTheme.bodyText1.copyWith(
                fontWeight: FontWeight.bold,
                color: finalTextColor,
              ),
        ),
      ),
    );
  }
}

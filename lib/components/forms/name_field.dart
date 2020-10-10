import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:dicery/styles.dart' as styles;

class NameField extends StatelessWidget {
  final TextEditingController _controller;

  NameField({@required controller}) : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: styles.TextField.copyWith(
        hintText: 'Your Name',
        helperText: ' ',
      ),
      validator: (value) => value.isEmpty ? 'Please enter your name.' : null,
      maxLength: 11,
      maxLengthEnforced: true,
      keyboardType: TextInputType.name,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'))
      ],
      controller: _controller,
      style: TextStyle(
        color: Colors.black,
      ),
    );
  }
}

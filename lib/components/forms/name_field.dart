import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:dicery/styles.dart' as styles;

class NameField extends StatelessWidget {
  final TextEditingController _controller;

  NameField({@required controller}) : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: 16,
      maxLengthEnforced: true,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter(RegExp(r'[a-zA-Z0-9]'))
      ],
      controller: _controller,
      style: TextStyle(
        color: Colors.black,
      ),
      decoration: styles.TextField.copyWith(hintText: 'Your Name'),
    );
  }
}

import 'package:calorie_mate/general_components/body_text%20copy.dart';
import 'package:calorie_mate/general_components/text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';

// ignore: must_be_immutable
class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final keyboardType;
  final enabled;
  Set<TextInputFormatter> inputFormatters = Set<TextInputFormatter>();
  RoundedInputField({
    Key key,
    this.hintText,
    this.icon,
    this.onChanged,
    this.keyboardType,
    this.enabled,
    inputFormatters,
  }) : super(key: key) {
    if (inputFormatters != null) this.inputFormatters = inputFormatters;
  }

  @override
  Widget build(BuildContext context) {
    if (keyboardType == TextInputType.number) {
      inputFormatters.add(WhitelistingTextInputFormatter.digitsOnly);
    }
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: kPrimaryDarkColor,
        keyboardType: this.keyboardType,
        enabled: this.enabled,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kIconColor,
            size: kIconSize,
          ),
          hintText: hintText,
          border: InputBorder.none,
          hintStyle: BodyTextStyle(),
          labelStyle: BodyTextStyle()
        ),
        inputFormatters: inputFormatters.toList(),
      ),
    );
  }
}

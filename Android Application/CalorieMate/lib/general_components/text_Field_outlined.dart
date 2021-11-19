import 'package:flutter/material.dart';

import '../constants.dart';
import 'body_text.dart';
import 'h2.dart';
import 'h3.dart';

// ignore: must_be_immutable
class TextFieldOutlined extends StatefulWidget {
  TextEditingController _textEditingController = TextEditingController();

  TextFieldOutlined({
    this.textFieldIcon = const Icon(
      Icons.keyboard,
    ),
    this.textFieldText,
    this.obscure = false,
    this.keyboardType = TextInputType.text,
    this.isValidEntry,
    this.onChanged,
  }) {
    if (isValidEntry == null) {
      isValidEntry = (dynamic a) {
        return '';
      };
    }
  }
  Function onChanged;
  final Widget textFieldIcon;
  final String textFieldText;
  final bool obscure;
  final TextInputType keyboardType;
  dynamic retValue;
  String Function(dynamic)
      isValidEntry; //checks if the entry complies with pre set restrictions

  @override
  _TextFieldOutlinedState createState() => _TextFieldOutlinedState();

  dynamic getReturnValue() => retValue;
}

class _TextFieldOutlinedState extends State<TextFieldOutlined> {
  Color color = kNavyBlue;
  String warningMessage = '';

  bool _togglePassword;

  @override
  void initState() {
    _togglePassword = false;
  }

  @override
  Widget build(BuildContext context) {
    var none;
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          height: 50.0,
          // color: kTextLightColor,
          child: TextFormField(
            style: H2TextStyle(),
            cursorColor: kNavyBlue,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: kNavyBlue, width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black26, width: 1.5),
                borderRadius: BorderRadius.circular(12),
              ),
              labelText: widget.textFieldText,
              prefixIcon: widget.textFieldIcon,
              labelStyle: H3TextStyle(color: kTextDarkColor),
              suffixIcon: widget.obscure
                  ? IconButton(
                      icon: Icon(
                        _togglePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: kIconColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _togglePassword = !_togglePassword;
                        });
                      },
                    )
                  : none,
            ),
            keyboardType: widget.keyboardType,
            maxLines: (widget.keyboardType == TextInputType.multiline) ? 3 : 1,
            // obscureText: widget.obscure,
            obscureText: widget.obscure ? !_togglePassword : false,
            controller: widget._textEditingController,
            onChanged: (value) {
              setState(() {
                warningMessage = widget.isValidEntry(value);
                print(warningMessage);
                if (warningMessage == '') {
                  widget.retValue = value;
                  color = kNavyBlue;
                } else {
                  color = kNavyBlue;
                }
              });
            },
          ),
        ),
        (warningMessage != '')
            ? (Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 5.0),
                child: Text(
                  warningMessage,
                  textAlign: TextAlign.left,
                  style: BodyTextStyle(color: Colors.red),
                ),
              ))
            : (Container(
                height: 0.0,
              )),
      ],
    );
  }
}

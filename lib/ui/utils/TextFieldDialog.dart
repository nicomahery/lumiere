import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldDialog extends StatelessWidget {
  String? _textFieldValue;
  final Function(String) confirmFunction;
  final Function cancelFunction;
  TextFieldDialog({required this.confirmFunction, required this.cancelFunction, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('TextField in Dialog'),
      content: TextField(
        onChanged: (value) {
          this._textFieldValue = value;
        },
        decoration: InputDecoration(hintText: "Text Field in Dialog"),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            this.cancelFunction();
          },
        ),
        TextButton(
          child: Text('OK'),
          onPressed: () {
            this.confirmFunction(this._textFieldValue!);
          },
        ),
      ],
    );;
  }
}

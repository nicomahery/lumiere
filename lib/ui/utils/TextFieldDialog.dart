import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldDialog extends StatelessWidget {
  String? _textFieldValue;
  final Function(String) confirmFunction;
  final Function cancelFunction;
  final String title;
  final String inputHintText;
  TextFieldDialog({required this.title, required this.inputHintText, required this.confirmFunction, required this.cancelFunction, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(this.title),
      content: TextField(
        onChanged: (value) {
          this._textFieldValue = value;
        },
        decoration: InputDecoration(hintText: this.inputHintText),
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

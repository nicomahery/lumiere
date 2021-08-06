import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldDialog extends StatelessWidget {
  String? _textFieldValue;
  final Function(String) confirmFunction;
  final Function cancelFunction;
  final Widget? title;
  final String inputHintText;
  TextFieldDialog({this.title, required this.inputHintText, required this.confirmFunction, required this.cancelFunction, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: this.title,
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
            if (this._textFieldValue == null || this._textFieldValue!.length < 1) {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Error"),
                    content: Text('Label name cannot be empty'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                              'OK'
                          )
                      )
                    ]
                  )
              );
            }
            else {
              this.confirmFunction(this._textFieldValue!);
            }
          },
        ),
      ],
    );;
  }
}

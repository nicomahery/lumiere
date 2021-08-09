import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:lumiere/services/LabelService.dart';

import 'TextFieldDialog.dart';

class SelectLabelDialog extends StatefulWidget {
  const SelectLabelDialog({Key? key}) : super(key: key);

  @override
  _SelectLabelDialogState createState() => _SelectLabelDialogState();
}

class _SelectLabelDialogState extends State<SelectLabelDialog> {
  late LabelService _labelService;


  _SelectLabelDialogState() {
    this._labelService = GetIt.instance<LabelService>();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Select label'),
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => TextFieldDialog(
                          title: Text('Add new label'),
                          inputHintText: 'label',
                          cancelFunction: () => Navigator.pop(context),
                          confirmFunction: (String newLabel) {
                            this._labelService.addLabel(newLabel);
                            Navigator.pop(context);
                            setState(() {

                            });
                            Fluttertoast.showToast(
                                msg: "$newLabel label added",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.SNACKBAR,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.blueGrey,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          })
                  );
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                )
            )
          ],
        ),
        body: ListView.builder(
          itemCount: this._labelService.labelList.length,
          itemBuilder: (context, index) {
            String label = this._labelService.labelList[index];
            return ListTile(
              leading: Icon(Icons.label, color: this._labelService.getColorsForLabelIndex(index)),
              title: Text(this._labelService.labelList[index]),
              onTap: () => Navigator.of(context).pop(label),
            );
          },
        ),
      )
    );
  }
}

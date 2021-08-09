
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:lumiere/services/LabelService.dart';
import 'package:lumiere/ui/utils/SelectLabelDialog.dart';
import 'package:lumiere/ui/utils/StoragePictureDialog.dart';

import 'XFilePreviewWidget.dart';

class PicturePreviewDialog extends StatefulWidget {
  final XFile xFile;
  final String? initialSelectedLabel;
  const PicturePreviewDialog({required this.xFile, this.initialSelectedLabel, Key? key}) : super(key: key);

  @override
  _PicturePreviewDialogState createState() => _PicturePreviewDialogState();
}

class _PicturePreviewDialogState extends State<PicturePreviewDialog> {
  late LabelService _labelService;
  String? selectedLabel;

  @override
  void initState() {
    this._labelService = GetIt.instance<LabelService>();
    this.selectedLabel = this.widget.initialSelectedLabel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String label = this.selectedLabel ?? '';
    Color labelColor = this._labelService.getColorsForLabel(label);
    return Dialog(
      child: Container(
        height: height * 0.90,
        width: width * 0.7,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(flex: 1),
            Container(
              height: height * 0.6,
              width: width * 0.65,
              child: XFilePreviewWidget(this.widget.xFile)
            ),
            Spacer(flex: 1),
            Container(
              width: width * 0.65,
              child: OutlinedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => SelectLabelDialog()
                  ).then((newSelectedLabel) {
                    setState(() {
                      this.selectedLabel = newSelectedLabel;
                    });
                  });
                },
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(labelColor),
                  shadowColor: MaterialStateProperty.all<Color>(labelColor)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(flex: 1),
                    Padding(
                      padding: EdgeInsets.only(right: width * 0.001),
                      child: Icon(
                        Icons.label,
                        color: labelColor,
                      ),
                    ),
                    Text(
                      label,
                      style: TextStyle(
                        color: labelColor
                      ),
                    ),
                    Spacer(flex: 1),
                  ],
                )
              ),
            ),
            Spacer(flex: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(flex: 2),
                Container(
                  width: width * 0.3,
                  height: width * 0.3,
                  child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.red)
                      ),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: width * 0.15,
                      )
                  ),
                ),
                Spacer(flex: 1),
                Container(
                  width: width * 0.3,
                  height: width * 0.3,
                  child: ElevatedButton(
                    onPressed: () {
                      if (this.selectedLabel == null) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('No selected label'),
                            content: Text('Please select a label first'),

                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('OK')
                              ),
                            ],
                          ),
                        );
                      }
                      else {
                        Navigator.of(context).pop();
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => StoragePictureDialog(
                              xFile: this.widget.xFile,
                              selectedLabel: this.selectedLabel!,
                            )
                        );
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.green)
                    ),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: width * 0.15,
                    ),
                  ),
                ),
                Spacer(flex: 2),
              ],
            ),
            Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
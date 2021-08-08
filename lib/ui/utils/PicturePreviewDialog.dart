
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lumiere/ui/utils/StoragePictureDialog.dart';

class PicturePreviewDialog extends StatelessWidget {
  final XFile xFile;
  final String? selectedLabel;
  const PicturePreviewDialog({required this.xFile, this.selectedLabel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Dialog(
      child: Container(
        height: height * 0.85,
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
              child: FutureBuilder<Uint8List>(
                future: this.xFile.readAsBytes(),
                builder: (context, AsyncSnapshot<Uint8List> snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return Image.memory(
                        snapshot.data!
                    );
                  }
                  if (snapshot.hasError) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.error),
                        Text('Unable to display preview')
                      ],
                    );
                  }
                  return CircularProgressIndicator(color: Colors.blue,);
                },
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
                      Navigator.of(context).pop();
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => StoragePictureDialog(
                            xFile: this.xFile,
                            selectedLabel: this.selectedLabel,
                          )
                      );
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

import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PicturePreviewDialog extends StatefulWidget {
  final XFile xFile;
  final String? selectedLabel;
  const PicturePreviewDialog({required this.xFile, this.selectedLabel, Key? key}) : super(key: key);

  @override
  _PicturePreviewDialogState createState() => _PicturePreviewDialogState();
}

class _PicturePreviewDialogState extends State<PicturePreviewDialog> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Dialog(
      child: Container(
        height: height * 0.8,
        width: width * 0.6,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(flex: 1),
            Container(
              height: height * 0.5,
              width: width * 0.5,
              child: FutureBuilder<Uint8List>(
                future: this.widget.xFile.readAsBytes(),
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
          ],
        ),
      ),
    );
  }
}

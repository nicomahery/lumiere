import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class XFilePreviewWidget extends StatelessWidget {
  final XFile xFile;
  const XFilePreviewWidget(this.xFile, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
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
    );
  }
}

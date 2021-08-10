import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FileImagePreviewWidget extends StatelessWidget {
  final XFile? xFile;
  final File? file;
  FileImagePreviewWidget({this.xFile, this.file, Key? key}) : super(key: key) {
    if ((this.file == null && this.xFile == null) || (this.file != null && this.xFile != null)) {
      throw('one of xFile and File must be null and the other can\'t be null');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: this.xFile != null ? this.xFile!.readAsBytes() : this.file!.readAsBytes(),
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

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoragePictureDialog extends StatefulWidget {
  final XFile xFile;
  final String? selectedLabel;
  const StoragePictureDialog({required this.xFile, this.selectedLabel, Key? key}) : super(key: key);

  @override
  _StoragePictureDialogState createState() => _StoragePictureDialogState();
}

class _StoragePictureDialogState extends State<StoragePictureDialog> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Dialog(
      child: Container(
        height: height * 0.85,
        width: width * 0.7,
        color: Colors.white,
      ),
    );
  }
}


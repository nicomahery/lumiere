import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lumiere/services/LabelService.dart';
import 'package:lumiere/ui/utils/StoragePictureDialog.dart';

class LabelGalleryPage extends StatefulWidget {
  final String selectedLabel;
  const LabelGalleryPage({Key? key, required this.selectedLabel}) : super(key: key);

  @override
  _LabelGalleryPageState createState() => _LabelGalleryPageState();
}

class _LabelGalleryPageState extends State<LabelGalleryPage> {
  late LabelService _labelService;

  @override
  void initState() {
    this._labelService = GetIt.instance<LabelService>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<File> fileList = this._labelService.getFilesForLabel(this.widget.selectedLabel);
    return Scaffold(
      appBar: AppBar(
        title: Text('${this.widget.selectedLabel} gallery'),
      ),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4
          ),
          itemCount: fileList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Image.file(fileList[index]),
              onTap: () => showDialog(
                  context: context,
                  builder: (context) => StoragePictureDialog(
                    file: fileList[index],
                    selectedLabel: this.widget.selectedLabel,
                  )
              ).then((value) {
                setState(() {

                });
              }),
            );
          }),
    );
  }
}

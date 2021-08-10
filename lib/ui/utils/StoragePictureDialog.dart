import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:lumiere/services/ApiService.dart';
import 'package:lumiere/services/LabelService.dart';
import 'package:lumiere/ui/utils/FileImagePreviewWidget.dart';
import 'package:path/path.dart';

class StoragePictureDialog extends StatefulWidget {
  final XFile? xFile;
  final File? file;
  final String selectedLabel;
  const StoragePictureDialog({this.xFile, this.file, required this.selectedLabel, Key? key}) : super(key: key);

  @override
  _StoragePictureDialogState createState() => _StoragePictureDialogState();
}

class _StoragePictureDialogState extends State<StoragePictureDialog> {
  late ApiService _apiService;
  late LabelService _labelService;

  @override
  void initState() {
    this._apiService = GetIt.instance<ApiService>();
    this._labelService = GetIt.instance<LabelService>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String label = this.widget.selectedLabel;
    Color labelColor = this._labelService.getColorsForLabel(label);
    return Dialog(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Select storage'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(flex: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(flex: 1),
                Padding(
                  padding: EdgeInsets.only(right: width * 0.01),
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
            ),
            Container(
                height: height * 0.6,
                width: width * 0.6,
                child: FileImagePreviewWidget(xFile: this.widget.xFile, file: this.widget.file)
            ),
            Spacer(flex: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(flex: 1),
                Container(
                  width: width * 0.20,
                  height: width * 0.20,
                  child: ElevatedButton(
                      onPressed: () async {
                        EasyLoading.show(status: 'saving...');
                        if (this.widget.xFile != null) {
                          await this.widget.xFile!.saveTo(this._labelService.getPathLocationForLabel(this.widget.selectedLabel, basename(this.widget.xFile!.path)));
                        }
                        EasyLoading.dismiss();
                        Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.red)
                      ),
                      child: Center(
                        child: Icon(
                          Icons.phone_android,
                          color: Colors.white,
                          size: width * 0.115,
                        ),
                      )
                  ),
                ),
                Icon(
                  Icons.arrow_back,
                  color: Colors.grey,
                  size: width * 0.05,
                ),
                Icon(
                  Icons.image,
                  color: Colors.grey,
                  size: width * 0.10,
                ),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.grey,
                  size: width * 0.05,
                ),

                Container(
                  width: width * 0.2,
                  height: width * 0.2,
                  child: ElevatedButton(
                    onPressed: () async {
                      EasyLoading.show(status: 'sending...');
                      if (await this._apiService.sendFileToApi(this.widget.selectedLabel, xFile: this.widget.xFile, file: this.widget.file)) {
                        Navigator.of(context).pop();
                      }
                      else {
                        Fluttertoast.showToast(
                            msg: 'Unable to upload image (check configuration)',
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.SNACKBAR,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                      EasyLoading.dismiss();
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.green)
                    ),
                    child: Center(
                      child: Icon(
                        Icons.dns,
                        color: Colors.white,
                        size: width * 0.115,
                      ),
                    ),
                  ),
                ),
                Spacer(flex: 1),
              ],
            ),
            Spacer(flex: 2),
          ],
        )
      ),
    );
  }
}


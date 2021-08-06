import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lumiere/services/ParametersService.dart';
import 'package:lumiere/ui/utils/PicturePreviewDialog.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> with WidgetsBindingObserver {
  late CameraController _cameraController;
  String? _selectedLabel;
  late ParametersService _parametersService;
  int _selectCamera = 0;

  @override
  void initState() {
    super.initState();
    this._parametersService = GetIt.instance<ParametersService>();
    this._cameraController = CameraController(
      this._parametersService.cameras[this._selectCamera],
      ResolutionPreset.max,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    this._cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    this._cameraController.dispose();
    super.dispose();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (!this._cameraController.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      this._cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
        onNewCameraSelected(this._cameraController.description);
    }
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    await this._cameraController.dispose();
    this._cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.max,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        child: CameraPreview(
          this._cameraController,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 25,
                      )
                  ),
                )
              ),
              Positioned(
                  bottom: 50,
                  child: InkWell(
                    onTap: () async {
                      XFile xFile = await this._cameraController.takePicture();
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => PicturePreviewDialog(
                              xFile: xFile
                          )
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.zero,
                      width: width * 0.20,
                      height: width * 0.20,
                      child: Center(
                        child: Icon(
                          Icons.camera,
                          color: Colors.white,
                          size: width * 0.20,
                        )
                      ),
                    ),
                  )
              ),
              /*Positioned(
                  bottom: 50,
                  left: 50,
                  child: InkWell(
                    onTap: () async {
                      this._selectCamera = (this._selectCamera + 1) % (this._parametersService.cameras.length - 1);
                      this.onNewCameraSelected(this._parametersService.cameras[this._selectCamera]);
                    },
                    child: Container(
                      margin: EdgeInsets.zero,
                      width: width * 0.20,
                      height: width * 0.20,
                      child: Center(
                          child: Icon(
                            Icons.flip_camera_ios,
                            color: Colors.white,
                            size: width * 0.20,
                          )
                      ),
                    ),
                  )
              ),*/
            ],
          ),
        ),
        width: width,
        height: height,
      ),
    );
  }
}

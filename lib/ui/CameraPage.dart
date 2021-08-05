import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lumiere/services/ParametersService.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _cameraController;
  String? _selectedLabel;
  late ParametersService _parametersService;

  @override
  void initState() {
    super.initState();
    this._parametersService = GetIt.instance<ParametersService>();
    this._cameraController = CameraController(this._parametersService.cameras[0], ResolutionPreset.max);
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
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit labels'),
        actions: [
          IconButton(
              onPressed: () => print('tot'),
              icon: const Icon(
                Icons.label,
                color: Colors.white,
              )
          )
        ],
      ),
      body:
      Container(
        child: CameraPreview(
          this._cameraController,
          child: Stack(
            children: [

            ],
          ),
        ),
        width: width,
        height: height,
      ),
    );
  }
}

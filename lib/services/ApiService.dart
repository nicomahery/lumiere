import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lumiere/services/ParametersService.dart';
import 'package:path/path.dart';

const String UPLOAD_FILE_URI = 'uploadFile';
const String TEST_CONNECTION_URI = 'testConnection';

class ApiService {
  late ParametersService _parametersService;
  late Dio _dio;

  ApiService() {
    this._parametersService = GetIt.instance<ParametersService>();
    this._dio = Dio();
  }

  Future<bool> sendFileToApi(String label, {XFile? xFile, File? file}) async {
    if ((xFile == null && file == null) || (xFile != null && file != null)) {
      throw('one of xFile and File must be null and the other can\'t be null');
    }
    String filename = basename(file != null ? file.path : xFile!.path);
    Response response = await this._dio.post(
      'https://${this._parametersService.serverUrl!}/$UPLOAD_FILE_URI/$label',
      data: FormData.fromMap({
        'access-key': this._parametersService.accessKey ?? '',
        'file': MultipartFile.fromBytes(file != null ? file.readAsBytesSync() : await xFile!.readAsBytes(), filename: filename)
      })
    );
    if (response.statusCode == 200 && response.data['fileName'] == filename) {
      if (file != null) {
        file.deleteSync();
      }
      return true;
    }
    return false;
  }

  Future<bool> testConnectionToApi() async {
    String payload = DateTime.now().toIso8601String();
    try {
      Response response = await this._dio.post(
          'https://${this._parametersService.serverUrl!}/$TEST_CONNECTION_URI',
          data: FormData.fromMap({
            'access-key': this._parametersService.accessKey ?? '',
            'payload': payload
          })
      );
      return response.statusCode == 200 && response.data == payload;
    }
    catch (exception) {
      print(exception);
      return false;
    }
  }
}
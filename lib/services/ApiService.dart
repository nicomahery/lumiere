import 'dart:io';

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

  Future<bool> sendFileToApi(File file, String label) async {
    Response response = await this._dio.post(
      'https://${this._parametersService.serverUrl!}/$UPLOAD_FILE_URI/$label',
      data: FormData.fromMap({
        'access-key': this._parametersService.accessKey ?? '',
        'file': MultipartFile.fromBytes(file.readAsBytesSync(), filename: basename(file.path))
      })
    );
    if (response.statusCode == 200 && response.data['fileName'] == basename(file.path)) {
      file.deleteSync();
      return true;
    }
    return false;
  }

  Future<bool> testConnectionToApi() async {
    String payload = DateTime.now().toIso8601String();
    Response response = await this._dio.post(
        'https://${this._parametersService.serverUrl!}/$TEST_CONNECTION_URI',
        data: FormData.fromMap({
          'access-key': this._parametersService.accessKey ?? '',
          'payload': payload
        })
    );
    return response.statusCode == 200 && response.data == payload;
  }
}
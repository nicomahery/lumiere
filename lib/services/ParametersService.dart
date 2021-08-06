import 'package:camera/camera.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String SERVER_URL_PARAMETER_KEY = 'server_url_parameter';
const String SERVER_ACCESS_KEY_PARAMETER_KEY = 'server_access_key_parameter';

class ParametersService {
  String? _serverUrl;
  String? _accessKey;

  String? get accessKey => this._accessKey;
  String? get serverUrl => this._serverUrl;
  late List<CameraDescription> cameras;

  ParametersService() {
    this._getParametersFromPreferences();
  }

  /// Initialises every parameters from shared preferences
  Future<void> _getParametersFromPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    this.cameras = await availableCameras();
    this._serverUrl = preferences.getString(SERVER_URL_PARAMETER_KEY);
    this._accessKey = preferences.getString(SERVER_ACCESS_KEY_PARAMETER_KEY);
  }

  /// Sets [this._serverUrl] and [this._accessKey] to the given [serverUrl] and [accessKey]
  void setServerUrlAndAccessKey(String? serverUrl, String? accessKey) {
    this._serverUrl = serverUrl;
    this._accessKey = accessKey;
    this._saveParametersFromPreferences();
  }

  /// Saves every parameters from shared preferences
  Future<void> _saveParametersFromPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (this._serverUrl != null) {
      preferences.setString(SERVER_URL_PARAMETER_KEY, this._serverUrl!);
    }
    if (this._accessKey != null) {
      preferences.setString(SERVER_ACCESS_KEY_PARAMETER_KEY, this._accessKey!);
    }
  }
}
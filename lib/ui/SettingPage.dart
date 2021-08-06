import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:lumiere/services/ApiService.dart';
import 'package:lumiere/services/ParametersService.dart';
import 'package:lumiere/ui/utils/TextFieldDialog.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late ParametersService _parametersService;
  late ApiService _apiService;
  String? _apiUrl;
  String? _apiAccessKey;

  @override
  void initState() {
    this._parametersService = GetIt.instance<ParametersService>();
    this._apiService = GetIt.instance<ApiService>();
    super.initState();
    this._apiUrl = this._parametersService.serverUrl;
    this._apiAccessKey = this._parametersService.accessKey;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        actions: [
          IconButton(
              onPressed: () async {
                bool testSuccessful = await this._apiService.testConnectionToApi();
                Fluttertoast.showToast(
                    msg: testSuccessful ? 'Test successful' : 'Test failed',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.SNACKBAR,
                    timeInSecForIosWeb: 1,
                    backgroundColor: testSuccessful ? Colors.green : Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              },
              icon: const Icon(
                Icons.cloud_upload,
                color: Colors.white,
              )
          ),
          IconButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: Text('Do you want to save settings ?'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                            'Cancel'
                        )
                    ),
                    TextButton(
                        onPressed: () {
                          this._parametersService.setServerUrlAndAccessKey(this._apiUrl, this._apiAccessKey);
                          Navigator.pop(context);
                          setState(() {

                          });
                          Fluttertoast.showToast(
                              msg: 'Settings saved',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.SNACKBAR,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.blueGrey,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        },
                        child: Text(
                            'Confirm'
                        )
                    )
                  ],
                ),
              ),
              icon: const Icon(
                Icons.save,
                color: Colors.white,
              )
          )
        ],
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            titlePadding: const EdgeInsets.all(20),
            title: 'API Server',
            tiles: [
              SettingsTile(
                title: 'Server URL',
                subtitle: this._apiUrl ?? '',
                leading: Icon(Icons.dns),
                onPressed: (context) => showDialog(
                    context: context,
                    builder: (context) => TextFieldDialog(
                        inputHintText: 'Server URL "www.example.com"',
                        cancelFunction: () => Navigator.pop(context),
                        confirmFunction: (String newUrl) {
                          this._apiUrl = newUrl;
                          Navigator.pop(context);
                          setState(() {

                          });
                        })
                ),
              ),
              SettingsTile(
                title: 'Access key',
                subtitle: this._apiAccessKey != null ? '*****************' : '',
                leading: Icon(Icons.vpn_key),
                onPressed: (context) => showDialog(
                    context: context,
                    builder: (context) => TextFieldDialog(
                        inputHintText: 'Access key',
                        cancelFunction: () => Navigator.pop(context),
                        confirmFunction: (String newAccessKey) {
                          this._apiAccessKey = newAccessKey;
                          Navigator.pop(context);
                          setState(() {

                          });
                        })
                ),
              ),

            ],
          )
        ],
      ),
    );
  }
}

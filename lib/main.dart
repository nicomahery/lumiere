import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:lumiere/services/ApiService.dart';
import 'package:lumiere/services/LabelService.dart';
import 'package:lumiere/services/ParametersService.dart';
import 'package:lumiere/ui/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GetIt.instance.registerSingleton(LabelService());
  GetIt.instance.registerSingleton(ParametersService());
  GetIt.instance.registerSingleton(ApiService());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    EasyLoading.instance.loadingStyle = EasyLoadingStyle.light;
    return MaterialApp(
      title: 'Lumiere',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
    );
  }
}

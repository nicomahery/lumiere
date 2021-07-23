import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lumiere/services/LabelService.dart';
import 'package:lumiere/ui/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  GetIt.instance.registerSingleton(LabelService());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lumiere',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

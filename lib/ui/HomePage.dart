

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lumiere/ui/CameraPage.dart';
import 'package:lumiere/ui/SettingPage.dart';

import 'LabelListPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lumiere'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(flex: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(flex: 5),
                Container(
                  width: width * 0.49,
                  height: height * 0.43,
                  child: ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Spacer(flex: 2),
                        Padding(
                          padding: EdgeInsets.only(right: width * 0.001),
                          child: Icon(
                            Icons.label,
                            color: Colors.white,
                            size: width * 0.09,
                          ),
                        ),
                        Text(
                          'Edit labels',
                          style: TextStyle(
                              fontSize: width * 0.065
                          ),
                        ),
                        Spacer(flex: 2),
                      ],
                    ),
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LabelListPage())),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurpleAccent)
                    ),
                  ),
                ),
                Spacer(flex: 5),
                Container(
                  width: width * 0.49,
                  height: height * 0.43,
                  child: ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Spacer(flex: 2),
                        Padding(
                          padding: EdgeInsets.only(right: width * 0.001),
                          child: Icon(
                            Icons.settings,
                            color: Colors.white,
                            size: width * 0.09,
                          ),
                        ),
                        Text(
                          'Settings',
                          style: TextStyle(
                              fontSize: width * 0.065
                          ),
                        ),
                        Spacer(flex: 2),
                      ],
                    ),
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SettingPage())),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.teal)
                    ),
                  ),
                ),
                Spacer(flex: 5),

              ],
            ),
            Spacer(flex: 5),
            Container(
              width: width * 0.98,
              height: height * 0.43,
              child: ElevatedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(flex: 2),
                    Padding(
                      padding: EdgeInsets.only(right: width * 0.001),
                      child: Icon(
                        Icons.camera,
                        color: Colors.white,
                        size: width * 0.09,
                      ),
                    ),
                    Text(
                      'Take picture',
                      style: TextStyle(
                        fontSize: width * 0.07
                      ),
                    ),
                    Spacer(flex: 2),
                  ],
                ),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CameraPage())),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red)
                ),
              ),
            ),
            Spacer(flex: 5),
          ],
        ),
      ),
    );
  }
}
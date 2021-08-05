

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lumiere/ui/CameraPage.dart';

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
                        Icon(
                          Icons.label,
                          color: Colors.white,
                          size: width * 0.09,
                        ),
                        Spacer(flex: 2),
                        Text(
                          'Edit labels',
                          style: TextStyle(
                              fontSize: width * 0.065
                          ),
                        ),
                        Spacer(flex: 6),
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
                        Icon(
                          Icons.settings,
                          color: Colors.white,
                          size: width * 0.09,
                        ),
                        Spacer(flex: 2),
                        Text(
                          'Settings',
                          style: TextStyle(
                              fontSize: width * 0.065
                          ),
                        ),
                        Spacer(flex: 6),
                      ],
                    ),
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CameraPage())),
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
                    Icon(
                      Icons.camera,
                      color: Colors.white,
                      size: width * 0.09,
                    ),
                    Spacer(flex: 2),
                    Text(
                      'Take picture',
                      style: TextStyle(
                        fontSize: width * 0.07
                      ),
                    ),
                    Spacer(flex: 6),
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
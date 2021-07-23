import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lumiere/services/LabelService.dart';

class LabelPage extends StatefulWidget {
  const LabelPage({Key? key}) : super(key: key);

  @override
  _LabelPageState createState() => _LabelPageState();
}

class _LabelPageState extends State<LabelPage> {
  late LabelService _labelService;

  @override
  void initState() {
    this._labelService = GetIt.instance<LabelService>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit labels'),
        actions: [
          IconButton(
              onPressed: onPressed,
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              )
          )
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: this._labelService.labelList.length,
          itemBuilder: (context, index) {
            String label = this._labelService.labelList[index];
            return ListTile(
              leading: Icon(Icons.label, color: this._labelService.getColorsForLabelIndex(index)),
              title: Text(this._labelService.labelList[index]),
              trailing: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Delete $label label'),
                            content: Text('Do you want to remove the $label label ?'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'cancel'
                                  )
                              ),
                              TextButton(
                                  onPressed: () {
                                    this._labelService.removeLabel(label);
                                    Navigator.pop(context);
                                    setState(() {

                                    });
                                  },
                                  child: Text(
                                    'confirm'
                                  )
                              )
                            ],
                          ),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Delete $label label'),
                          content: Text('Do you want to remove the $label label ?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                    'cancel'
                                )
                            ),
                            TextButton(
                                onPressed: () {
                                  this._labelService.removeLabel(label);
                                  Navigator.pop(context);
                                  setState(() {

                                  });
                                },
                                child: Text(
                                    'confirm'
                                )
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lumiere/services/LabelService.dart';
import 'package:lumiere/ui/utils/TextFieldDialog.dart';

class LabelListPage extends StatefulWidget {
  const LabelListPage({Key? key}) : super(key: key);

  @override
  _LabelListPageState createState() => _LabelListPageState();
}

class _LabelListPageState extends State<LabelListPage> {
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
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => TextFieldDialog(
                        title: 'Add new label',
                        inputHintText: 'label',
                        cancelFunction: () => Navigator.pop(context),
                        confirmFunction: (String newLabel) {
                          this._labelService.addLabel(newLabel);
                          Navigator.pop(context);
                          setState(() {

                          });
                        })
                );
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              )
          )
        ],
      ),
      body: ListView.builder(
        itemCount: this._labelService.labelList.length,
        itemBuilder: (context, index) {
          String label = this._labelService.labelList[index];
          return ListTile(
            leading: Icon(Icons.label, color: this._labelService.getColorsForLabelIndex(index)),
            title: Text(this._labelService.labelList[index]),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              color: Colors.red,
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

          );
        },
      ),
    );
  }
}

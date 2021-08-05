import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;

const String LABEL_LIST_PREFERENCE_KEY = 'label_list';
const List<Color> LABEL_COLOR_LIST = [
  Colors.blue,
  Colors.red,
  Colors.green,
  Colors.black,
  Colors.yellow,
  Colors.orange,
  Colors.lime,
  Colors.blueGrey,
  Colors.blueAccent,
  Colors.deepPurple,
  Colors.pinkAccent,
  Colors.teal,
  Colors.brown,
  Colors.indigo
];

class LabelService{
  /// String containing the path location of app data directory
  late String _appDirectoryLocation;
  /// List containing every registered labels
  late List<String> _labelList;

  /// Getter of the label list this.[_labelList]
  List<String> get labelList => this._labelList;

  LabelService() {
    this._initValues();
  }

  /// Initialises the label list this.[_labelList] from shared preferences,
  /// initialises the path of the app data directory this.[_appDirectoryLocation]
  /// and create directories
  void _initValues() async {
    await this._getAppDirectoryLocation();
    await this._getLabelListFromPreferences();
  }

  /// Initialises the label list this.[_labelList] from shared preferences
  Future<void> _getLabelListFromPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    this._labelList = preferences.getStringList(LABEL_LIST_PREFERENCE_KEY) ?? [];
    if (this._labelList.isNotEmpty) {
      for(String label in this._labelList) {
        this._createDirectoryIfNotExist(label);
      }
    }
  }

  /// Initialises the path of the app data directory this.[_appDirectoryLocation]
  Future<void> _getAppDirectoryLocation() async {
    Directory dir = await getApplicationDocumentsDirectory();
    this._appDirectoryLocation = dir.path;
  }

  /// Saves every label in this.[_labelList] into shared preferences (persistence)
  Future<void> _saveLabelListToPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setStringList(LABEL_LIST_PREFERENCE_KEY, this._labelList);
  }

  /// Adds a new label [labelName] to the label list this.[_labelList],
  /// creates the associated directory
  /// and saves the label list this.[_labelList] to preferences
  void addLabel(String labelName) {
    if (!this._labelList.contains(labelName)) {
      this._labelList.add(labelName);
      this._createDirectoryIfNotExist(labelName);
      this._saveLabelListToPreferences();
    }
  }

  /// Removes the label of name [labelName] from the label list this.[_labelList],
  /// deletes the associated directory and saves the list
  /// and saves the label list this.[_labelList] to preferences
  void removeLabel(String labelName) {
    if (this._labelList.contains(labelName)) {
      this._labelList.remove(labelName);
      this._deleteDirectoryIfExist(labelName);
      this._saveLabelListToPreferences();
    }
  }

  /// Creates a directory of name [directoryName] if it doesn't already exists at the app data location
  void _createDirectoryIfNotExist(String directoryName) {
    String directoryLocation = path.Context(style: path.Style.posix).join(this._appDirectoryLocation, directoryName);
    Directory directory = new Directory(directoryLocation);
    directory.exists().then((exists) {
      if (!exists) {
        directory.createSync(recursive: true);
      }
    });
  }

  /// Deletes a directory of name [directoryName] if it already exists at the app data location
  void _deleteDirectoryIfExist(String directoryName) {
    String directoryLocation = path.Context(style: path.Style.posix).join(this._appDirectoryLocation, directoryName);
    Directory directory = new Directory(directoryLocation);
    directory.exists().then((exists) {
      if (exists) {
        directory.deleteSync(recursive: true);
      }
    });
  }

  /// Returns associated colors for the index of the label
  Color getColorsForLabelIndex(int index) {
    return LABEL_COLOR_LIST[index % LABEL_COLOR_LIST.length];
  }
}
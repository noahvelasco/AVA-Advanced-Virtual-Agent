import 'package:flutter/material.dart';

/*
This input controller is for handling the GPT-3.5-Turbo API key. This is a controller 
since it needs to be modified at any time and needs to be accessible to various
widgets on the settings bottom sheet.
*/
class InputGPTKeyController extends ChangeNotifier {
  final TextEditingController inputGPTKeyTextEditingController =
      TextEditingController();

  String get text => inputGPTKeyTextEditingController.text;

  void setText(String text) {
    //update controller
    inputGPTKeyTextEditingController.text = text;
    debugPrint("InputGPTKeyController is now: $text");
    notifyListeners();
  }
}

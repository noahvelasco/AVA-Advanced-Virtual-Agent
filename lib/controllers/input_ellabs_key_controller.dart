import 'package:flutter/material.dart';

/*
This input controller is for handling the ElevenLabs API key. This is a controller 
since it needs to be modified at any time and needs to be accessible to various
widgets on the settings bottom sheet.
*/
class InputElLabsKeyController extends ChangeNotifier {
  final TextEditingController inputElLabsKeyTextEditingController =
      TextEditingController();

  String get text => inputElLabsKeyTextEditingController.text;

  void setText(String text) {
    //update controller
    inputElLabsKeyTextEditingController.text = text;
    debugPrint("InputElLabsKeyController is now: $text");
    notifyListeners();
  }
}

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

  void setText(BuildContext context, String text) {
    // final settingsProvider =
    //     Provider.of<SettingsProvider>(context, listen: false);

    //update controller
    inputElLabsKeyTextEditingController.text = text;

    //also update the settings provider
    // settingsProvider.setElLabsAPIKey(text);
    notifyListeners();
  }
}

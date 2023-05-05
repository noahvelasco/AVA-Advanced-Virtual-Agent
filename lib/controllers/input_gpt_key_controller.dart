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

  void setText(BuildContext context, String text) {
    // final settingsProvider =
    //     Provider.of<SettingsProvider>(context, listen: false);

    //update controller
    inputGPTKeyTextEditingController.text = text;

    //also update the settings provider
    // settingsProvider.setGPTAPIKey(text);
    notifyListeners();
  }
}

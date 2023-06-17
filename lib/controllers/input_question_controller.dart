/*
This input controller is for the input box in the home screen and is necessary since
the text controller needs to be accessible to various widgets on the home screen. Hence,
by making it a provider, it can be accessed from anywhere in the app.
*/

import 'package:flutter/material.dart';

class InputQuestionController extends ChangeNotifier {
  final TextEditingController inputQuestionTextEditingController =
      TextEditingController();

  String get text => inputQuestionTextEditingController.text;

  void setText(String text) {
    inputQuestionTextEditingController.text = text;
    notifyListeners();
  }
}

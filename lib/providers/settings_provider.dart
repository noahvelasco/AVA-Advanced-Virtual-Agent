import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  /* 

  _gptAPIKey: gpt-3.5-turbo api key
  _elLabsAPIKey: eleven-labs api key
  _gptTemp: gpt temperature
  _elLabsExpr: eleven-labs voice expressiveness
  _elLabsClar: eleven-labs voice clarity

  */

  //TODO: remove hard coded keys and instead allow for them to be set in intro pages
  String _gptAPIKey = '';
  String _elLabsAPIKey = '';

  double _gptTemp = 0.7;
  double _elLabsExpr = 0.15;
  double _elLabsClar = 0.75;

  String get gptAPIKey => _gptAPIKey;
  String get elevenLabsAPIKey => _elLabsAPIKey;
  double get gptTemp => _gptTemp;
  double get elLabsExpr => _elLabsExpr;
  double get elLabsClar => _elLabsClar;

  //TODO Checks if the key is valid
  bool isValidKey() {
    if (_gptAPIKey == '' || _elLabsAPIKey == '') {
      return false;
    }
    return true;
  }

  void setGPTAPIKey(String key) {
    debugPrint("JUST SET GPT API IN PROVIDER KEY TO $key");
    _gptAPIKey = key;
    notifyListeners();
  }

  void setElLabsAPIKey(String key) {
    debugPrint("JUST SET ELABS API IN PROVIDER KEY TO $key");
    _elLabsAPIKey = key;
    notifyListeners();
  }

  void setGPTTemp(double temp) {
    _gptTemp = temp;
    notifyListeners();
  }

  void setElLabsExpr(double expr) {
    _elLabsExpr = expr;
    notifyListeners();
  }

  void setElLabsClar(double clar) {
    _elLabsClar = clar;
    notifyListeners();
  }
}

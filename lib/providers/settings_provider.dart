import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  /* 
  _gptTemp: gpt temperature
  _elLabsExpr: eleven-labs voice expressiveness
  _elLabsClar: eleven-labs voice clarity
  */

  double _gptTemp = 0.7;
  double _elLabsExpr = 0.15;
  double _elLabsClar = 0.75;

  double get gptTemp => _gptTemp;
  double get elLabsExpr => _elLabsExpr;
  double get elLabsClar => _elLabsClar;

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

import 'package:flutter/material.dart';

class ShowError extends ChangeNotifier
{
  bool showError = false;

  void setShowErrorTrue()
  {
    showError = true;
    notifyListeners();
  }
  void setShowErrorFalse()
  {
    showError = false;
    notifyListeners();
  }
}
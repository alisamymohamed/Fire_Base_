import 'package:flutter/cupertino.dart';

class AdmainProvder extends ChangeNotifier {
  bool isAdmin = false;
  isAdmainFunfction(bool value) {
    isAdmin = value;
    notifyListeners();
  }
}

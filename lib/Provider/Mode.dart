import 'package:flutter/foundation.dart';

class ModalHub extends ChangeNotifier {
  bool load = false;

  isloading(bool value) {
    load = value;
    notifyListeners();
  }
}

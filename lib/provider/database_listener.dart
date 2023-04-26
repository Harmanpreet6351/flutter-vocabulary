import 'package:flutter/material.dart';

class DatabaseListener with ChangeNotifier {
  void dbUpdated() {
    notifyListeners();
  }
}

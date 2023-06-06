import 'package:flutter/material.dart';

class ZoomProvider extends ChangeNotifier {
  bool _zoomedIn = false;

  bool get zoomedIn => _zoomedIn;

  void setZoomedIn(bool newZoomState) {
    _zoomedIn = newZoomState;
    notifyListeners();
  }
}

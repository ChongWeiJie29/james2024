import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';

class CameraNotifier extends ChangeNotifier {
  late CameraDescription _camera;

  CameraDescription get camera => _camera;

  void setCamera(CameraDescription camera) {
    _camera = camera;
    notifyListeners();
  }
}

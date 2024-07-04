import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';

class CapturedImagesNotifiers extends ChangeNotifier {
  final List<XFile> _capturedImages = [];

  List<XFile> get capturedImages => _capturedImages;

  void addCapturedImages(XFile capturedImage) {
    _capturedImages.add(capturedImage);
  }
}

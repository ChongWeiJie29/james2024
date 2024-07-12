import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';

class CapturedImagesNotifiers extends ChangeNotifier {
  final List<XFile> _capturedImages = [];

  List<XFile> get capturedImages => _capturedImages;

  void addCapturedImages(int index, XFile capturedImage) {
    if (index > _capturedImages.length) return;

    if (index == _capturedImages.length) {
      _capturedImages.add(capturedImage);
    } else {
      _capturedImages[index] = capturedImage;
    }
    notifyListeners();
  }

  void clearImages() {
    _capturedImages.clear();
    notifyListeners();
  }
}

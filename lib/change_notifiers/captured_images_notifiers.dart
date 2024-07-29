import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:james2024/pages/scan/scan_common.dart';

class CapturedImagesNotifiers extends ChangeNotifier {
  final List<XFile> _capturedImages = [];
  final Set<String> _anglesTaken = {};

  List<XFile> get capturedImages => _capturedImages;
  Set<String> get anglesTaken => _anglesTaken;

  void addCapturedImages(int index, XFile capturedImage) {
    if (index > _capturedImages.length) return;

    if (index == _capturedImages.length) {
      _capturedImages.add(capturedImage);
      _anglesTaken.add(phoneAngles[index]);
    } else {
      _capturedImages[index] = capturedImage;
    }
    print("================== Hello, image captured ==================");
    notifyListeners();
  }

  void addAngleTaken(String angle) {
    _anglesTaken.add(angle);
    notifyListeners();
  }

  void clearImages() {
    _capturedImages.clear();
    _anglesTaken.clear();
    notifyListeners();
  }
}

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:james2024/pages/scan/scan_common.dart';
import 'package:image/image.dart' as img;

class CapturedImagesNotifiers extends ChangeNotifier {
  final List<XFile> _capturedImages = [];
  final Set<String> _anglesTaken = {};
  late double _widthRatio;
  late double _heightRatio;

  List<XFile> get capturedImages => _capturedImages;
  Set<String> get anglesTaken => _anglesTaken;

  Future<void> addCapturedImages(int index, XFile capturedImage) async {
    XFile cropped = await _cropImage(capturedImage);
    if (index > _capturedImages.length) return;

    if (index == _capturedImages.length) {
      _capturedImages.add(cropped);
      _anglesTaken.add(phoneAngles[index]);
    } else {
      _capturedImages[index] = cropped;
    }
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

  void setCroppingDimensions(double widthRatio, double heightRatio) {
    _widthRatio = widthRatio;
    _heightRatio = heightRatio;
    notifyListeners();
  }

  Future<XFile> _cropImage(XFile image) async {
    final img.Image imageFile =
        img.decodeImage(File(image.path).readAsBytesSync())!;
    final double height = imageFile.height * _heightRatio;
    final double width = imageFile.width * _widthRatio;
    final double left = (imageFile.width - width) / 2;
    final double top = (imageFile.height - height) / 2;
    final img.Image croppedImage = img.copyCrop(
      imageFile,
      x: left.toInt(),
      y: top.toInt(),
      width: width.toInt(),
      height: height.toInt(),
    );
    final File croppedFile = File(image.path);
    await croppedFile.writeAsBytes(img.encodeJpg(croppedImage));
    return XFile(croppedFile.path);
  }
}

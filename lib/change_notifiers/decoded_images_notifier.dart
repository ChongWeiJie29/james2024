import 'package:flutter/cupertino.dart';

class DecodedImagesNotifier extends ChangeNotifier {
  List<dynamic> _decodedImages = [];

  List<dynamic> get decodedImages => _decodedImages;

  void setDecodedImages(List<dynamic> decodedImages) {
    _decodedImages = decodedImages;
    notifyListeners();
  }
}

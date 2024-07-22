import 'package:flutter/cupertino.dart';

import 'package:james2024/pages/summary/bbox.dart';
import 'package:james2024/pages/summary/model_prediction.dart';

class DecodedImagesNotifier extends ChangeNotifier {
  /*
    List of max length 6. Each element is a list of all the dictionaries of each bounding box
  */
  List<dynamic> _decodedImages = [];

  List<ModelPrediction> get decodedImages => _convertDecodedImages(_decodedImages);

  void setDecodedImages(List<dynamic> decodedImages) {
    _decodedImages = decodedImages;
    notifyListeners();
  }

  void clearImages() {
    _decodedImages.clear();
    notifyListeners();
  }

  List<ModelPrediction> _convertDecodedImages(List<dynamic> decodedImages) {
    List<ModelPrediction> modelPredictions = [];
    for (dynamic img in decodedImages) {
      List<Bbox> predictions = [];
      for (dynamic bbox in img) {
        predictions.add(Bbox.fromJson(bbox));
      }
      modelPredictions.add(ModelPrediction(predictions: predictions));
    }
    return modelPredictions;
  }
}

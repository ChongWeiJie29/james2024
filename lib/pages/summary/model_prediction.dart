import 'package:flutter/cupertino.dart';

import 'bbox.dart';

/*
  Represents one captured image, consisting of a list of all
  the bounding boxes drawn by the model
*/
class ModelPrediction {
  List<Bbox> predictions;

  ModelPrediction({
    required this.predictions,
  });

  List<Widget> convertToWidgets(double parentHeight) {
    return predictions.map((bbox) {
      double factor = parentHeight / bbox.imageHeight;
      // if (bbox.category == PredictionType.scratch) {
      //   print(bbox.getArea());
      // }
      return Positioned(
        left: bbox.coordinates[0] * factor,
        top: bbox.coordinates[1] * factor,
        width: bbox.getWidth() * factor,
        height: bbox.getHeight() * factor,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(color: bbox.getWidgetColor(), width: 2.0),
          ),
        ),
      );
    }).toList();
  }

}

import 'package:flutter/cupertino.dart';

enum PredictionType {
  phone,
  scratch,
}

class Bbox {
  List<double> coordinates;
  PredictionType category;
  double score;
  double imageWidth;
  double imageHeight;

  Bbox({
    required this.coordinates,
    required this.category,
    required this.score,
    required this.imageWidth,
    required this.imageHeight,
  });

  factory Bbox.fromJson(dynamic json) {
    return Bbox(
      coordinates: List<double>.from(json['bbox'] as List),
      category: PredictionType.values.byName(json['category']),
      score: json['score'].toDouble(),
      imageWidth: json['imageWidth'].toDouble(),
      imageHeight: json['imageHeight'].toDouble(),
    );
  }

  CupertinoDynamicColor getWidgetColor() {
    switch (category) {
      case PredictionType.phone:
        return CupertinoColors.activeBlue;
      case PredictionType.scratch:
        return CupertinoColors.systemRed;
    }
  }
}

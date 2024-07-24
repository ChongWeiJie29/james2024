import 'package:flutter/cupertino.dart';

enum PredictionType {
  phone,
  scratch,
}

class Bbox {
  List<num> coordinates;
  PredictionType category;
  num score;
  num imageWidth;
  num imageHeight;

  Bbox({
    required this.coordinates,
    required this.category,
    required this.score,
    required this.imageWidth,
    required this.imageHeight,
  });

  factory Bbox.fromJson(dynamic json) {
    return Bbox(
      coordinates: List<num>.from(json['bbox'] as List),
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

  num getHeight() {
    return coordinates[3] - coordinates[1];
  }

  num getWidth() {
    return coordinates[2] - coordinates[0];
  }

  num getArea() {
    return getHeight() * getWidth();
  }
}

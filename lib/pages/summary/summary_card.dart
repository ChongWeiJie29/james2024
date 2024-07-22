import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:james2024/pages/summary/model_prediction.dart';

class SummaryCard extends StatefulWidget {
  const SummaryCard({
    super.key,
    required this.index,
    required this.capturedImage,
    required this.decodedImage,
    required this.parentHeight,
  });

  final int index;
  final XFile capturedImage;
  final ModelPrediction decodedImage;
  final double parentHeight;

  @override
  State<StatefulWidget> createState() => _SummaryCard();
}

class _SummaryCard extends State<SummaryCard> {
  late final File imageFile;
  double get _parentHeight => widget.parentHeight;
  ModelPrediction get _decodedImage => widget.decodedImage;

  @override
  void initState() {
    super.initState();
    imageFile = File(widget.capturedImage.path);
  }

  List<Widget> displayBoxes(BoxConstraints screen, File imageFile) {
    if (_decodedImage.isEmpty) return [];
    return _decodedImage.convertToWidgets(_parentHeight);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder (
      builder: (context, constraints) {
        // print('This is length of Summary Card ${constraints.maxWidth}');
        return Center(
          child: Stack(
            children: [
              Image.file(imageFile),
              ...displayBoxes(constraints, imageFile)
            ],
          ),
        );
      }
    );
  }
}

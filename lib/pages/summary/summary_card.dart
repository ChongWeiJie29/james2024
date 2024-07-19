import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';

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
  final List<dynamic> decodedImage;
  final double parentHeight;

  @override
  State<StatefulWidget> createState() => _SummaryCard();
}

class _SummaryCard extends State<SummaryCard> {
  late final File imageFile;
  get _parentHeight => widget.parentHeight;

  @override
  void initState() {
    super.initState();
    imageFile = File(widget.capturedImage.path);
  }

  List<Widget> displayBoxes(BoxConstraints screen, File imageFile) {
    if (widget.decodedImage.isEmpty) return [];

    return widget.decodedImage.map((result) {
      final factor = _parentHeight / result["imageHeight"];

      return Positioned(
        left: result["bbox"][0].toDouble() * factor,
        top: result["bbox"][1].toDouble() * factor,
        width: (result["bbox"][2] - result["bbox"][0]).toDouble() * factor,
        height: (result["bbox"][3] - result["bbox"][1]).toDouble() * factor,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(color: CupertinoColors.activeBlue, width: 2.0),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder (
      builder: (context, constraints) {
        print('This is length of Summary Card ${constraints.maxWidth}');
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

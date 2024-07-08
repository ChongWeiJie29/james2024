import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';

class SummaryCard extends StatefulWidget {
  const SummaryCard(
      {super.key,
      required this.index,
      // required this.model,
      required this.capturedImage,
      required this.decodedImage});

  final int index;
  // final FlutterVision model;
  final XFile capturedImage;
  final List<dynamic> decodedImage;

  @override
  State<StatefulWidget> createState() => _SummaryCard();
}

class _SummaryCard extends State<SummaryCard> {
  late final File imageFile;
  // List<Map<String, dynamic>> results = [];

  @override
  void initState() {
    super.initState();
    imageFile = File(widget.capturedImage.path);
    // detect();
  }

  // void detect() async {
  //   Uint8List byte = await imageFile.readAsBytes();
  //   final image = await decodeImageFromList(byte);
  //   imageHeight = image.height;
  //   imageWidth = image.width;
  //   final result = await widget.model.yoloOnImage(
  //       bytesList: byte,
  //       imageHeight: image.height,
  //       imageWidth: image.width,
  //       iouThreshold: 0.8,
  //       confThreshold: 0.8,
  //       classThreshold: 0.5);
  //   print(result);
  //   setState(() {
  //     results = result;
  //   });
  // }

  List<Widget> displayBoxes(Size screen, File imageFile) {
    if (widget.decodedImage.isEmpty) return [];

    Color colorPick = const Color.fromARGB(255, 50, 233, 30);
    return widget.decodedImage.map((result) {
      final factorX = screen.width / result["imageWidth"];
      final factorY = screen.height / result["imageHeight"];
      return Positioned(
        left: result["bbox"][0].toDouble() * factorX,
        top: result["bbox"][1].toDouble() * factorY,
        width: (result["bbox"][2] - result["bbox"][0]).toDouble() * factorX,
        height: (result["bbox"][3] - result["bbox"][1]).toDouble() * factorY,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(color: CupertinoColors.activeBlue, width: 2.0),
          ),
          child: Text(
            "${result['category']} ${(result['score'] * 100).toStringAsFixed(0)}%",
            style: TextStyle(
              background: Paint()..color = colorPick,
              color: CupertinoColors.black,
              fontSize: 18.0,
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
        children: [Image.file(imageFile), ...displayBoxes(size, imageFile)]);
  }
}

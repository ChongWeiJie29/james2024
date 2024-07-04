import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_vision/flutter_vision.dart';

class SummaryImages extends StatefulWidget {
  const SummaryImages({super.key, required this.capturedImages});

  final List<XFile> capturedImages;

  @override
  State<SummaryImages> createState() => _SummaryImagesState();
}

class _SummaryImagesState extends State<SummaryImages> {
  List<XFile> images = [];
  final FlutterVision _vision = FlutterVision();
  late final List<Map<String, dynamic>> capturedFiles;
  num imageWidth = 0;
  num imageHeight = 0;

  void getCapturedFiles() {
    capturedFiles = widget.capturedImages.map((xfile) {
      return {
        "file": File(xfile.path),
        "class": "",
        "boxLeft": 0.0,
        "boxTop": 0.0,
        "boxRight": 0.0,
        "boxBottom": 0.0
      };
    }).toList();
  }

  Future<void> initModel() async {
    await _vision.loadYoloModel(
        labels: 'assets/labels.txt',
        modelPath: 'assets/scratch100.tflite',
        modelVersion: "yolov8seg",
        quantization: false,
        numThreads: 1,
        useGpu: false);
  }

  Future<void> processImage() async {
    for (Map<String, dynamic> capturedFile in capturedFiles) {
      Uint8List byte = await capturedFile["file"].readAsBytes();
      final image = await decodeImageFromList(byte);
      imageWidth = image.width;
      imageHeight = image.height;
      final results = await _vision.yoloOnImage(
          bytesList: byte,
          imageHeight: image.height,
          imageWidth: image.width,
          iouThreshold: 0.4,
          classThreshold: 0.5);
      for (Map<String, dynamic> result in results) {
        capturedFile["class"] = result["tag"];
        capturedFile["boxLeft"] = result["box"][0];
        capturedFile["boxTop"] = result["box"][1];
        capturedFile["boxRight"] = result["box"][2];
        capturedFile["boxBottom"] = result["box"][3];
      }
    }
    print(capturedFiles); // Temporary for debugging to see detected results.
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getCapturedFiles();
    initModel();
    processImage();
  }

  @override
  void dispose() {
    _vision.closeYoloModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double parentWidth = MediaQuery.of(context).size.width;
    return SizedBox(
        width: imageWidth.toDouble(),
        height: imageHeight.toDouble(),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.capturedImages.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: parentWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.file(
                      capturedFiles[index]["file"],
                      fit: BoxFit.contain,
                    ),
                    Text(capturedFiles[index]["class"]),
                  ],
                ),
              ),
            );
          },
        ));
  }
}

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_vision/flutter_vision.dart';
import 'package:james2024/pages/scan/scan_camera_body/scan_camera_overlay.dart';

class ScanCameraWindow extends StatefulWidget {
  const ScanCameraWindow({
    super.key,
    required this.initializeControllerFuture,
    required this.controller,
    required this.phoneAngleState,
    required this.vision,
    required this.isSettingOverlay,
  });

  final Future<void> initializeControllerFuture;
  final CameraController controller;
  final int phoneAngleState;
  final FlutterVision vision;
  final bool isSettingOverlay;

  @override
  State<StatefulWidget> createState() => _ScanCameraWindow();
}

class _ScanCameraWindow extends State<ScanCameraWindow> {
  String phoneDetections = "";

  @override
  void initState() {
    super.initState();
    startInference();
  }

  startInference() async {
    widget.initializeControllerFuture
        .then((_) => {
              widget.controller
                  .startImageStream((CameraImage cameraImage) async {
                if (widget.isSettingOverlay) {
                  return;
                }
                processImage(cameraImage);
              })
            })
        .catchError((error) {
      return error;
      // do something on error
    });
  }

  processImage(CameraImage cameraImage) async {
    final results = await widget.vision.yoloOnFrame(
        bytesList: cameraImage.planes.map((plane) => plane.bytes).toList(),
        imageHeight: cameraImage.height,
        imageWidth: cameraImage.width,
        iouThreshold: 0.4,
        classThreshold: 0.5);
    for (var result in results) {
      String detectedClass = result['tag'];
      setState(() {
        phoneDetections += " $detectedClass";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: widget.initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AspectRatio(
              aspectRatio: 3 / 4,
              child: Stack(fit: StackFit.expand, children: [
                CameraPreview(widget.controller),
                ScanCameraOverlay(
                  phoneAngleState: widget.phoneAngleState,
                ),
                Text(phoneDetections),
              ]));
        } else {
          return const Center(child: CupertinoActivityIndicator());
        }
      },
    );
  }
}

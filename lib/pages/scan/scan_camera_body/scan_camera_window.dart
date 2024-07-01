import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:james2024/pages/scan/scan_camera_body/scan_camera_overlay.dart';

class ScanCameraWindow extends StatefulWidget {
  const ScanCameraWindow(
      {super.key,
      required this.initializeControllerFuture,
      required this.controller,
      required this.phoneAngleState});

  final Future<void> initializeControllerFuture;
  final CameraController controller;
  final int phoneAngleState;

  @override
  State<StatefulWidget> createState() => _ScanCameraWindow();
}

class _ScanCameraWindow extends State<ScanCameraWindow> {
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
                  padding: 50,
                  phoneAngleState: widget.phoneAngleState,
                )
              ]));
        } else {
          return const Center(child: CupertinoActivityIndicator());
        }
      },
    );
  }
}

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:james2024/pages/scan/scan_camera_body/scan_camera_window/scan_camera_overlay.dart';

class ScanCameraWindow extends StatefulWidget {
  const ScanCameraWindow({
    super.key,
    required this.controller,
    required this.phoneAngleState,
  });

  final CameraController controller;
  final int phoneAngleState;

  @override
  State<StatefulWidget> createState() => _ScanCameraWindow();
}

class _ScanCameraWindow extends State<ScanCameraWindow> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 3 / 4,
        child: Stack(fit: StackFit.expand, children: [
          CameraPreview(widget.controller),
          ScanCameraOverlay(
            phoneAngleState: widget.phoneAngleState,
          ),
        ]));
  }
}

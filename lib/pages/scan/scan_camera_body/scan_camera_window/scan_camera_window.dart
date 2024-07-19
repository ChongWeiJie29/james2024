import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:james2024/pages/scan/scan_camera_body/scan_camera_window/scan_camera_overlay.dart';

class ScanCameraWindow extends StatelessWidget {
  const ScanCameraWindow({
    super.key,
    required this.controller,
    required this.phoneAngleState,
  });

  final CameraController controller;
  final int phoneAngleState;
  final double aspectRatio = 3 / 4;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double width = constraints.maxWidth;
      return AspectRatio(
        aspectRatio: aspectRatio,
        child: CameraPreview(controller,
            child: ScanCameraOverlay(
              phoneAngleState: phoneAngleState,
              cameraWidth: width,
              aspectRatio: aspectRatio,
            )),
      );
    });
  }
}

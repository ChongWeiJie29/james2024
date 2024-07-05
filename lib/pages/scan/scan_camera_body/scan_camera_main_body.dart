import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:james2024/pages/scan/scan_camera_body/scan_camera_control_panel/scan_camera_capture_button.dart';
import 'package:james2024/pages/scan/scan_camera_body/scan_camera_control_panel/scan_camera_state_button.dart';
import 'package:james2024/pages/scan/scan_camera_body/scan_camera_window/scan_camera_window.dart';

class ScanCameraMainBody extends StatelessWidget {
  const ScanCameraMainBody(
      {super.key,
      required this.controller,
      required this.intializeControllerFuture,
      required this.phoneAngleState,
      required this.updatePhoneAngle});

  final CameraController controller;
  final Future<void> intializeControllerFuture;
  final int phoneAngleState;
  final Function(int) updatePhoneAngle;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ScanCameraWindow(
            controller: controller,
            phoneAngleState: phoneAngleState,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ScanCameraStateButton(
                  phoneAngleState: phoneAngleState,
                  updatePhoneAngleState: updatePhoneAngle,
                ),
                ScanCameraCaptureButton(
                  phoneAngleState: phoneAngleState,
                  updatePhoneAngleState: updatePhoneAngle,
                  initializeControllerFuture: intializeControllerFuture,
                  controller: controller,
                ),
              ]),
        ]);
  }
}

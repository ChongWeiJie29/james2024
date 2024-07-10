import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:james2024/pages/scan/scan_camera_body/scan_camera_control_panel/scan_camera_capture_button.dart';
import 'package:james2024/pages/scan/scan_camera_body/scan_camera_control_panel/scan_camera_state_button.dart';
import 'package:james2024/pages/scan/scan_camera_body/scan_camera_window/scan_camera_window.dart';

class ScanCameraMainBody extends StatefulWidget {
  const ScanCameraMainBody({
    super.key,
    required this.controller,
    required this.initializeControllerFuture,
  });

  final CameraController controller;
  final Future<void> initializeControllerFuture;

  @override
  State<StatefulWidget> createState() => _ScanCameraMainBody();
}

class _ScanCameraMainBody extends State<ScanCameraMainBody> {
  int _phoneAngleState = 0;

  void updatePhoneAngle(int newState) {
    setState(() {
      if (newState > 5) return;
      _phoneAngleState = newState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ScanCameraWindow(
          controller: widget.controller,
          phoneAngleState: _phoneAngleState,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: ScanCameraStateButton(
                phoneAngleState: _phoneAngleState,
                updatePhoneAngleState: updatePhoneAngle,
              ),
            ),
            ScanCameraCaptureButton(
              phoneAngleState: _phoneAngleState,
              updatePhoneAngleState: updatePhoneAngle,
              initializeControllerFuture: widget.initializeControllerFuture,
              controller: widget.controller,
            ),
          ]
        ),
      ]
    );
  }
}

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
    required this.isLoading,
    required this.phoneAngleState,
    required this.updatePhoneAngle,
  });

  final CameraController controller;
  final Future<void> initializeControllerFuture;
  final bool isLoading;
  final int phoneAngleState;
  final Function(int) updatePhoneAngle;

  @override
  State<StatefulWidget> createState() => _ScanCameraMainBody();
}

class _ScanCameraMainBody extends State<ScanCameraMainBody> {

  bool get _isLoading => widget.isLoading;
  int get _phoneAngleState => widget.phoneAngleState;
  Function(int) get _updatePhoneAngle => widget.updatePhoneAngle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ScanCameraWindow(
          controller: widget.controller,
          phoneAngleState: _phoneAngleState,
        ),
        ScanCameraStateButton(
          phoneAngleState: _phoneAngleState,
          updatePhoneAngleState: _updatePhoneAngle,
        ),
        ScanCameraCaptureButton(
          phoneAngleState: _phoneAngleState,
          updatePhoneAngleState: _updatePhoneAngle,
          initializeControllerFuture: widget.initializeControllerFuture,
          controller: widget.controller,
          isLoading: _isLoading,
        ),
        const SizedBox(height: 10),
      ]
    );
  }
}

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:james2024/pages/scan/scan_camera_body/scan_camera_capture_button.dart';
import 'package:james2024/pages/scan/scan_camera_body/scan_camera_state_button.dart';
import 'package:james2024/pages/scan/scan_camera_body/scan_camera_window.dart';

class ScanCameraBody extends StatefulWidget {
  const ScanCameraBody({super.key});

  @override
  State<StatefulWidget> createState() => _ScanCameraBody();
}

class _ScanCameraBody extends State<ScanCameraBody> {
  late List<CameraDescription> _cameras;
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  int _phoneAngleState = 0;

  void updatePhoneAngle(int newState) {
    setState(() {
      _phoneAngleState = newState;
    });
  }

  @override
  void initState() {
    super.initState();
    _setUpCamera();
  }

  void _setUpCamera() async {
    try {
      _cameras = await availableCameras();
      _controller = CameraController(
          _cameras.firstWhere((description) =>
              description.lensDirection == CameraLensDirection.back),
          ResolutionPreset.medium);
      _initializeControllerFuture = _controller.initialize();
    } on CameraException catch (_) {
      // do something on error
    }

    // Leave this here. It is important for to trigger a rebuild, once the camera is initialized.
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ScanCameraWindow(
            initializeControllerFuture: _initializeControllerFuture,
            controller: _controller,
          ),
          ScanCameraStateButton(
              phoneAngleState: _phoneAngleState,
              updatePhoneAngleState: updatePhoneAngle),
          ScanCameraCaptureButton(
            initializeControllerFuture: _initializeControllerFuture,
            controller: _controller,
          ),
        ]);
  }
}

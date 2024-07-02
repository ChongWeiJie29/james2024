import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_vision/flutter_vision.dart';
import 'package:james2024/pages/scan/scan_camera_body/scan_camera_capture_button.dart';
import 'package:james2024/pages/scan/scan_camera_body/scan_camera_state_button.dart';
import 'package:james2024/pages/scan/scan_camera_body/scan_camera_window.dart';

class ScanCameraBody extends StatefulWidget {
  const ScanCameraBody({super.key});

  @override
  State<StatefulWidget> createState() => _ScanCameraBody();
}

class _ScanCameraBody extends State<ScanCameraBody> {
  final FlutterVision _vision = FlutterVision();
  late List<CameraDescription> _cameras;
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  int _phoneAngleState = 0;
  bool _isSettingOverlay = false;

  void setIsSettingOverlay(bool newState) {
    setState(() {
      _isSettingOverlay = newState;
    });
  }

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
      await _vision.loadYoloModel(
          labels: 'assets/labels.txt',
          modelPath: 'assets/scratch100.tflite',
          modelVersion: "yolov8seg",
          quantization: true,
          numThreads: 2,
          useGpu: false);
    } on CameraException catch (_) {
      // do something on error
    }

    // Leave this here. It is important for to trigger a rebuild, once the camera is initialized.
    setState(() {});
  }

  @override
  void dispose() {
    _controller.stopImageStream();
    _controller.dispose();
    _vision.closeYoloModel();
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
            phoneAngleState: _phoneAngleState,
            vision: _vision,
            isSettingOverlay: _isSettingOverlay,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ScanCameraStateButton(
                    phoneAngleState: _phoneAngleState,
                    updatePhoneAngleState: updatePhoneAngle,
                    setIsSettingOverlay: setIsSettingOverlay),
                ScanCameraCaptureButton(
                  initializeControllerFuture: _initializeControllerFuture,
                  controller: _controller,
                ),
              ]),
        ]);
  }
}

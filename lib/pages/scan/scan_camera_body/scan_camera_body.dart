import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:james2024/pages/scan/scan_camera_body/scan_camera_main_body.dart';

class ScanCameraBody extends StatefulWidget {
  const ScanCameraBody({super.key, required this.camera});

  final CameraDescription camera;

  @override
  State<StatefulWidget> createState() => _ScanCameraBody();
}

class _ScanCameraBody extends State<ScanCameraBody> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _setUpCamera();
  }

  void _setUpCamera() async {
    try {
      _controller = CameraController(widget.camera, ResolutionPreset.medium);
      _initializeControllerFuture = _controller.initialize();
    } on CameraException catch (_) {
      // do something on error
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ScanCameraMainBody(
              controller: _controller,
              initializeControllerFuture: _initializeControllerFuture,
            );
          } else {
            return const Center(child: CupertinoActivityIndicator());
          }
        });
  }
}

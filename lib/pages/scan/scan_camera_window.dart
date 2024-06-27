import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';

class ScanCameraWindow extends StatefulWidget {
  const ScanCameraWindow({
    super.key,
    required this.initializeControllerFuture,
    required this.controller,
  });

  final Future<void> initializeControllerFuture;
  final CameraController controller;

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
          return CameraPreview(widget.controller);
        } else {
          return const Center(child: CupertinoActivityIndicator());
        }
      },
    );
  }
}

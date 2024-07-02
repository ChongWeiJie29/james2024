import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';

class ScanCameraCaptureButton extends StatefulWidget {
  const ScanCameraCaptureButton({
    super.key,
    required this.initializeControllerFuture,
    required this.controller,
  });

  final Future<void> initializeControllerFuture;
  final CameraController controller;

  @override
  State<StatefulWidget> createState() => _ScanCameraCaptureButton();
}

class _ScanCameraCaptureButton extends State<ScanCameraCaptureButton> {
  Widget _cameraCaptureButton() {
    return CupertinoButton(
      onPressed: () async {
        try {
          await widget.initializeControllerFuture;
          final image = await widget.controller.takePicture();
          // TODO: Save the image to SummaryPage
          print('Picture saved to ${image.path}');
        } on CameraException catch (_) {
          // do something on error
        }
      },
      child: const Icon(
        CupertinoIcons.camera,
        size: 30,
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: CupertinoColors.activeBlue,
              width: 2,
            )),
        child: _cameraCaptureButton());
  }
}

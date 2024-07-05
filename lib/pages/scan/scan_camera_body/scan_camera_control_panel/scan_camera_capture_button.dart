import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:james2024/change_notifiers/captured_images_notifiers.dart';
import 'package:provider/provider.dart';

class ScanCameraCaptureButton extends StatefulWidget {
  const ScanCameraCaptureButton({
    super.key,
    required this.phoneAngleState,
    required this.updatePhoneAngleState,
    required this.initializeControllerFuture,
    required this.controller,
  });

  final int phoneAngleState;
  final Function(int) updatePhoneAngleState;
  final Future<void> initializeControllerFuture;
  final CameraController controller;

  @override
  State<StatefulWidget> createState() => _ScanCameraCaptureButton();
}

class _ScanCameraCaptureButton extends State<ScanCameraCaptureButton> {
  Widget _cameraCaptureButton() {
    return Consumer<CapturedImagesNotifiers>(
        builder: (context, capturedImagesNotifier, child) {
      return CupertinoButton(
          onPressed: () async {
            try {
              await widget.initializeControllerFuture;
              final image = await widget.controller.takePicture();
              capturedImagesNotifier.addCapturedImages(
                  widget.phoneAngleState, image);
              widget.updatePhoneAngleState(widget.phoneAngleState + 1);
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
    });
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

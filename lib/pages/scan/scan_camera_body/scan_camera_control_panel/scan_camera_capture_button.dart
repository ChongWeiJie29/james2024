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
  State<ScanCameraCaptureButton> createState() => _ScanCameraCaptureButtonState();
}

class _ScanCameraCaptureButtonState extends State<ScanCameraCaptureButton> {
  int get _phoneAngleState => widget.phoneAngleState;

  Widget _cameraCaptureButton() {
    return Consumer<CapturedImagesNotifiers>(
        builder: (context, capturedImagesNotifier, child) {
      return SizedBox(
        height: 60,
        width: 60,
        child: ClipOval(
          child: CupertinoButton(
            color: CupertinoColors.white,
            onPressed: () async {
              try {
                await widget.initializeControllerFuture;
                final image = await widget.controller.takePicture();
                capturedImagesNotifier.addCapturedImages(_phoneAngleState, image);
                widget.updatePhoneAngleState(widget.phoneAngleState + 1);
              } on CameraException catch (_) {
                // do something on error
              }
            },
            child: Container(),
          ),
        ),
      );
    });
  }

  Widget _outerCircleBorder() {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: CupertinoColors.white,
          width: 4,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        _outerCircleBorder(),
        _cameraCaptureButton(),
      ],
    );
  }
}

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  Color _buttonColor = Colors.transparent;

  int get _phoneAngleState => widget.phoneAngleState;

  Widget _cameraCaptureButton() {
    return Consumer<CapturedImagesNotifiers>(
        builder: (context, capturedImagesNotifier, child) {
      return Listener(
        onPointerDown: (_) {
          setState(() {
            _buttonColor = CupertinoColors.systemGrey2;
          });
        },
        onPointerCancel: (_) {
          setState(() {
            _buttonColor = Colors.transparent;
          });
        },
        onPointerUp: (_) {
          setState(() {
            _buttonColor = Colors.transparent;
          });
        },
        child: CupertinoButton(
          pressedOpacity: 1,
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
          child: const Icon(
            CupertinoIcons.camera,
            size: 40,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _buttonColor,
        border: Border.all(
          color: CupertinoColors.systemBlue,
          width: 2,
        ),
      ),
      child: _cameraCaptureButton(),
    );
  }
}

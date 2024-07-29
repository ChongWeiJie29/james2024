import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:james2024/change_notifiers/captured_images_notifiers.dart';
import 'package:provider/provider.dart';

class ScanCameraCaptureButton extends StatefulWidget {
  const ScanCameraCaptureButton({
    super.key,
    required this.phoneAngleState,
    required this.updatePhoneAngleState,
    required this.initializeControllerFuture,
    required this.controller,
    required this.isLoading,
  });

  final int phoneAngleState;
  final Function(int) updatePhoneAngleState;
  final Future<void> initializeControllerFuture;
  final CameraController controller;
  final bool isLoading;

  @override
  State<ScanCameraCaptureButton> createState() =>
      _ScanCameraCaptureButtonState();
}

class _ScanCameraCaptureButtonState extends State<ScanCameraCaptureButton> {
  int get _phoneAngleState => widget.phoneAngleState;

  bool get _isButtonDisabled => widget.isLoading;

  Widget _cameraCaptureButton() {
    return Consumer<CapturedImagesNotifiers>(
        builder: (context, capturedImagesNotifier, child) {
      return SizedBox(
        height: 60,
        width: 60,
        child: ClipOval(
          child: CupertinoButton(
            color: CupertinoColors.white,
            onPressed: _isButtonDisabled
                ? null
                : () async {
                    try {
                      await widget.initializeControllerFuture;
                      final XFile image = await widget.controller.takePicture();
                      CroppedFile? cropped = await ImageCropper().cropImage(
                        sourcePath: image.path,
                        uiSettings: [
                          AndroidUiSettings(
                            lockAspectRatio: false,
                            hideBottomControls: true,
                          ),
                        ],
                      );
                      if (cropped == null) {
                        return;
                      }
                      capturedImagesNotifier.addCapturedImages(
                          _phoneAngleState, XFile(cropped.path));
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

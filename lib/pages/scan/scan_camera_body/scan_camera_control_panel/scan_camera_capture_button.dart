import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:james2024/change_notifiers/captured_images_notifiers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class ScanCameraCaptureButton extends StatelessWidget {
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

  Widget _cameraCaptureButton() {
    return Consumer<CapturedImagesNotifiers>(
        builder: (context, capturedImagesNotifier, child) {
      return CupertinoButton(
          onPressed: () async {
            try {
              await initializeControllerFuture;
              final image = await controller.takePicture();

              // temp code for testing with asset images
              final byteData =
                  await rootBundle.load('assets/images/20240619_161942.jpg');
              final file =
                  File('${(await getTemporaryDirectory()).path}/image.png');
              await file.writeAsBytes(byteData.buffer
                  .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
              XFile xFile = XFile(file.path);
              capturedImagesNotifier.addCapturedImages(phoneAngleState, xFile);

              // capturedImagesNotifier.addCapturedImages(phoneAngleState, image);
              updatePhoneAngleState(phoneAngleState + 1);
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

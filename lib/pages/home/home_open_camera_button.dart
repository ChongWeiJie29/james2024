import 'package:flutter/cupertino.dart';
import 'package:james2024/change_notifiers/camera_notifier.dart';
import 'package:provider/provider.dart';

class HomeOpenCameraButton extends StatelessWidget {
  const HomeOpenCameraButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CameraNotifier>(builder: (context, cameraNotifier, child) {
      return CupertinoButton.filled(
        onPressed: () {
          Navigator.pushNamed(context, '/scan',
              arguments: cameraNotifier.camera);
        },
        child: const Text(
          'Open Camera',
          style: TextStyle(fontSize: 20),
        ),
      );
    });
  }
}

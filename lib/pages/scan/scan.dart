import 'package:flutter/cupertino.dart';
import 'package:james2024/change_notifiers/camera_notifier.dart';
import 'package:james2024/pages/scan/scan_camera_body/scan_camera_body.dart';
import 'package:james2024/pages/scan/scan_camera_top_bar/scan_top_bar.dart';
import 'package:provider/provider.dart';

class ScanningPage extends StatelessWidget {
  const ScanningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CameraNotifier>(
      builder: (context, cameraNotifier, child) {
        return PopScope(
          canPop: false,
          child: CupertinoPageScaffold(
            navigationBar: const ScanTopBar(),
            child: ScanCameraBody(camera: cameraNotifier.camera),
          ),
        );
      },
    );
  }
}

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:james2024/change_notifiers/captured_images_notifiers.dart';
import 'package:james2024/pages/scan/scan_camera_body/scan_camera_body.dart';
import 'package:james2024/pages/scan/scan_camera_top_bar/scan_top_bar.dart';
import 'package:provider/provider.dart';

class ScanningPage extends StatelessWidget {
  const ScanningPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CameraDescription camera =
        ModalRoute.of(context)!.settings.arguments as CameraDescription;
    return ChangeNotifierProvider(
        create: (context) => CapturedImagesNotifiers(),
        child: PopScope(
          canPop: false,
          child: CupertinoPageScaffold(
            navigationBar: const ScanTopBar(),
            child: ScanCameraBody(camera: camera),
          ),
        ));
  }
}

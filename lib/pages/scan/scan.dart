import 'package:flutter/cupertino.dart';
import 'package:james2024/pages/scan/scan_camera_body/scan_camera_body.dart';
import 'package:james2024/pages/scan/scan_camera_top_bar/scan_top_bar.dart';

class ScanningPage extends StatelessWidget {
  const ScanningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PopScope(
      canPop: false,
      child: CupertinoPageScaffold(
        navigationBar: ScanTopBar(),
        child: ScanCameraBody(),
      ),
    );
  }
}

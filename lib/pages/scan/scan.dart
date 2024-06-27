import 'package:flutter/cupertino.dart';
import 'package:james2024/pages/scan/scan_camera_body.dart';
import 'package:james2024/pages/scan/scan_top_bar.dart';

class ScanningPage extends StatelessWidget {
  const ScanningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: ScanTopBar(),
      child: ScanCameraBody(),
    );
  }
}

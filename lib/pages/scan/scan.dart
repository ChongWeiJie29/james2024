import 'package:flutter/cupertino.dart';
import 'package:james2024/change_notifiers/camera_notifier.dart';
import 'package:james2024/pages/scan/scan_camera_body/scan_camera_body.dart';
import 'package:james2024/pages/scan/scan_camera_top_bar/scan_top_bar.dart';
import 'package:provider/provider.dart';

class ScanningPage extends StatefulWidget {
  const ScanningPage({super.key});

  @override
  State<ScanningPage> createState() => _ScanningPageState();
}

class _ScanningPageState extends State<ScanningPage> {
  bool _isLoading = false;
  int _phoneAngleState = 0;

  void _updateLoadingState(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  void _updatePhoneAngle(int newState) {
    setState(() {
      if (newState > 5) return;
      _phoneAngleState = newState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CameraNotifier>(
      builder: (context, cameraNotifier, child) {
        return PopScope(
          canPop: false,
          child: CupertinoPageScaffold(
            navigationBar: ScanTopBar(
                isLoading: _isLoading,
                updateLoadingState: _updateLoadingState,
                updatePhoneAngle: _updatePhoneAngle,
            ),
            child: ScanCameraBody(
              camera: cameraNotifier.camera,
              isLoading: _isLoading,
              phoneAngleState: _phoneAngleState,
              updatePhoneAngle: _updatePhoneAngle,
            ),
          ),
        );
      },
    );
  }
}

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:james2024/pages/scan/scan_camera_body/scan_camera_window/scan_camera_overlay.dart';

class ScanCameraWindow extends StatefulWidget {
  const ScanCameraWindow({
    super.key,
    required this.controller,
    required this.phoneAngleState,
  });

  final CameraController controller;
  final int phoneAngleState;

  @override
  State<ScanCameraWindow> createState() => _ScanCameraWindowState();
}

class _ScanCameraWindowState extends State<ScanCameraWindow> {
  final double aspectRatio = 3 / 4;

  CameraController get _controller => widget.controller;

  int get _phoneAngleState => widget.phoneAngleState;
  bool _showFocusCircle = false;
  double _x = 0;
  double _y = 0;

  Future<void> _focusCamera(TapUpDetails details) async {
    if (_controller.value.isInitialized) {
      setState(() {
        _showFocusCircle = true;
      });
      _x = details.localPosition.dx;
      _y = details.localPosition.dy;
      double fullWidth = MediaQuery.of(context).size.width;
      double cameraHeight = fullWidth * _controller.value.aspectRatio;
      double xp = _x / fullWidth;
      double yp = _y / cameraHeight;
      Offset point = Offset(xp, yp);

      await _controller.setFocusPoint(point);
      _controller.setExposurePoint(point);
      setState(() {
        Future.delayed(const Duration(seconds: 2)).whenComplete(() {
          setState(() {
            _showFocusCircle = false;
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double width = constraints.maxWidth;
      return AspectRatio(
        aspectRatio: aspectRatio,
        child: GestureDetector(
          onTapUp: (details) {
            _focusCamera(details);
          },
          child: Stack(
            children: [
              CameraPreview(
                _controller,
                child: ScanCameraOverlay(
                  phoneAngleState: _phoneAngleState,
                  cameraWidth: width,
                  aspectRatio: aspectRatio,
                ),
              ),
              if (_showFocusCircle)
                Positioned(
                  top: _y - 20,
                  left: _x - 20,
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: CupertinoColors.white, width: 1.5),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }
}

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:james2024/change_notifiers/captured_images_notifiers.dart';

class ScanCameraOverlay extends StatefulWidget {
  const ScanCameraOverlay({
    super.key,
    required this.phoneAngleState,
    required this.cameraWidth,
    required this.aspectRatio,
  });

  final int phoneAngleState;
  final double cameraWidth;
  final double aspectRatio;

  @override
  State<StatefulWidget> createState() => _ScanCameraOverlay();
}

class _ScanCameraOverlay extends State<ScanCameraOverlay> {
  double get _cameraWidth => widget.cameraWidth;
  double get _cameraHeight => _cameraWidth * widget.aspectRatio;
  double _widthRatio = 0;
  double _heightRatio = 0;

  @override
  void initState() {
    super.initState();
  }

  void calculatePadding() {
    switch (widget.phoneAngleState) {
      case 0:
      case 1:
        setState(() {
          _widthRatio = 3 / 5;
          _heightRatio = 4 / 5;
        });
      case 2:
      case 4:
        setState(() {
          _widthRatio = 1 / 6;
          _heightRatio = 3 / 4;
        });
      case 3:
      case 5:
        setState(() {
          _widthRatio = 1 / 8;
          _heightRatio = 4 / 5;
        });
    }
  }

  double _getPadding(double ratio, double length) {
    return (length - ratio * length) / 2;
  }

  @override
  Widget build(BuildContext context) {
    calculatePadding();
    return Consumer<CapturedImagesNotifiers>(
        builder: (context, capturedImagesNotifier, child) {
      capturedImagesNotifier.setCroppingDimensions(_widthRatio, _heightRatio);
      return LayoutBuilder(builder: (context, constraints) {
        Color color = const Color(0x55000000);
        return Stack(fit: StackFit.expand, children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  width: _getPadding(_widthRatio, _cameraWidth), color: color)),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  width: _getPadding(_widthRatio, _cameraWidth), color: color)),
          Align(
              alignment: Alignment.topCenter,
              child: Container(
                  margin: EdgeInsets.only(
                      left: _getPadding(_widthRatio, _cameraWidth),
                      right: _getPadding(_widthRatio, _cameraWidth)),
                  height: _getPadding(_heightRatio, _cameraHeight),
                  color: color)),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  margin: EdgeInsets.only(
                      left: _getPadding(_widthRatio, _cameraWidth),
                      right: _getPadding(_widthRatio, _cameraWidth)),
                  height: _getPadding(_heightRatio, _cameraHeight),
                  color: color)),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: _getPadding(_widthRatio, _cameraWidth),
                vertical: _getPadding(_heightRatio, _cameraHeight)),
            decoration: BoxDecoration(
                border: Border.all(color: CupertinoColors.activeBlue)),
          )
        ]);
      });
    });
  }
}

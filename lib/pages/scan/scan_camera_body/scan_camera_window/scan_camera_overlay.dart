import 'package:flutter/cupertino.dart';

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
  double _horizontalPadding = 0;
  double _verticalPadding = 0;

  @override
  void initState() {
    super.initState();
  }

  void calculatePadding() {
    switch (widget.phoneAngleState) {
      case 0:
      case 1:
        setState(() {
          _horizontalPadding = 1 / 5 * _cameraWidth;
          _verticalPadding = 1 / 10 * _cameraHeight;
        });
      case 2:
      case 4:
        setState(() {
          _horizontalPadding = 5 / 12 * _cameraWidth;
          _verticalPadding = 1 / 8 * _cameraHeight;
        });
      case 3:
      case 5:
        setState(() {
          _horizontalPadding = 7 / 16 * _cameraWidth;
          _verticalPadding = 1 / 10 * _cameraHeight;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    calculatePadding();
    return LayoutBuilder(builder: (context, constraints) {
      Color color = const Color(0x55000000);
      return Stack(fit: StackFit.expand, children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Container(width: _horizontalPadding, color: color)),
        Align(
            alignment: Alignment.centerRight,
            child: Container(width: _horizontalPadding, color: color)),
        Align(
            alignment: Alignment.topCenter,
            child: Container(
                margin: EdgeInsets.only(
                    left: _horizontalPadding, right: _horizontalPadding),
                height: _verticalPadding,
                color: color)),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                margin: EdgeInsets.only(
                    left: _horizontalPadding, right: _horizontalPadding),
                height: _verticalPadding,
                color: color)),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: _horizontalPadding, vertical: _verticalPadding),
          decoration: BoxDecoration(
              border: Border.all(color: CupertinoColors.activeBlue)),
        )
      ]);
    });
  }
}

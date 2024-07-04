import 'package:flutter/cupertino.dart';

class ScanCameraOverlay extends StatefulWidget {
  const ScanCameraOverlay({
    super.key,
    required this.phoneAngleState,
  });

  final int phoneAngleState;

  @override
  State<StatefulWidget> createState() => _ScanCameraOverlay();
}

class _ScanCameraOverlay extends State<ScanCameraOverlay> {
  double horizontalPadding = 0;
  double verticalPadding = 0;

  @override
  void initState() {
    super.initState();
  }

  calculatePadding() {
    switch (widget.phoneAngleState) {
      case 0:
      case 1:
        setState(() {
          horizontalPadding = 100;
          verticalPadding = 100;
        });
      case 2:
      case 4:
        setState(() {
          verticalPadding = 175;
          horizontalPadding = 175;
        });
      case 3:
      case 5:
        setState(() {
          horizontalPadding = 175;
          verticalPadding = 100;
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
            child: Container(width: horizontalPadding, color: color)),
        Align(
            alignment: Alignment.centerRight,
            child: Container(width: horizontalPadding, color: color)),
        Align(
            alignment: Alignment.topCenter,
            child: Container(
                margin: EdgeInsets.only(
                    left: horizontalPadding, right: horizontalPadding),
                height: verticalPadding,
                color: color)),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                margin: EdgeInsets.only(
                    left: horizontalPadding, right: horizontalPadding),
                height: verticalPadding,
                color: color)),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: horizontalPadding, vertical: verticalPadding),
          decoration: BoxDecoration(
              border: Border.all(color: CupertinoColors.activeBlue)),
        )
      ]);
    });
  }
}

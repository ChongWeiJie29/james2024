import 'package:flutter/cupertino.dart';
import 'package:james2024/change_notifiers/captured_images_notifiers.dart';
import 'package:james2024/pages/scan/scan_common.dart';
import 'package:provider/provider.dart';

class ScanCameraStateButton extends StatefulWidget {
  const ScanCameraStateButton({
    super.key,
    required this.phoneAngleState,
    required this.updatePhoneAngleState,
  });

  final int phoneAngleState;
  final Function(int) updatePhoneAngleState;

  @override
  State<StatefulWidget> createState() => _ScanCameraStateButton();
}

class _ScanCameraStateButton extends State<ScanCameraStateButton> {
  final Map<String, int> _angleToIndex = {
    for (String angle in phoneAngles) angle: phoneAngles.indexOf(angle)
  };

  int get _phoneAngleState => widget.phoneAngleState;

  @override
  Widget build(BuildContext context) {
    return Consumer<CapturedImagesNotifiers>(
        builder: (context, capturedImagesNotifier, child) {
      capturedImagesNotifier.addAngleTaken(phoneAngles[_phoneAngleState]);
      return Container(
        padding: EdgeInsets.zero,
        width: MediaQuery.of(context).size.width,
        child: CupertinoSegmentedControl(
          padding: EdgeInsets.zero,
          pressedColor: CupertinoColors.systemBackground.resolveFrom(context),
          borderColor: CupertinoColors.systemBackground.resolveFrom(context),
          // selectedColor: CupertinoColors.systemGrey5,
          groupValue: phoneAngles[_phoneAngleState],
          children: <String, Container>{
            for (String angle in phoneAngles)
              angle: Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                padding: EdgeInsets.zero,
                child: Text(
                  angle,
                  softWrap: false,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight:
                        capturedImagesNotifier.anglesTaken.contains(angle)
                            ? FontWeight.bold
                            : FontWeight.normal,
                    color: capturedImagesNotifier.anglesTaken.contains(angle)
                        ? CupertinoColors.white
                        : CupertinoColors.inactiveGray,
                  ),
                ),
              )
          },
          onValueChanged: (String? newValue) {
            if (newValue != null &&
                capturedImagesNotifier.anglesTaken.contains(newValue)) {
              widget.updatePhoneAngleState(_angleToIndex[newValue]!);
            }
          },
        ),
      );
    });
  }
}

import 'package:flutter/cupertino.dart';
import 'package:james2024/pages/scan/scan_common.dart';

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
    for (String angle in phoneAngles) angle : phoneAngles.indexOf(angle)
  };
  int get _phoneAngleState => widget.phoneAngleState;

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl(
      backgroundColor: CupertinoColors.systemBackground.resolveFrom(context),
      thumbColor: CupertinoColors.systemGrey2,
      groupValue: phoneAngles[_phoneAngleState],
      children: <String, Text>{
        for (String angle in phoneAngles) angle : Text(angle)
      },
      onValueChanged: (String? newValue) {
        if (newValue != null) {
          widget.updatePhoneAngleState(_angleToIndex[newValue]!);
        }
      },
    );
  }
}

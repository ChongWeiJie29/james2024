import 'package:flutter/cupertino.dart';
import 'package:james2024/pages/scan/scan_common.dart';

class ScanCameraStateButton extends StatefulWidget {
  const ScanCameraStateButton({
    super.key,
    required this.phoneAngleState,
    required this.updatePhoneAngleState,
    required this.setIsSettingOverlay,
  });

  final int phoneAngleState;
  final Function(int) updatePhoneAngleState;
  final Function(bool) setIsSettingOverlay;

  @override
  State<StatefulWidget> createState() => _ScanCameraStateButton();
}

class _ScanCameraStateButton extends State<ScanCameraStateButton> {
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: child,
      ),
    ).whenComplete(() => widget.setIsSettingOverlay(false));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        widget.setIsSettingOverlay(true);
        _showDialog(
          CupertinoPicker(
            itemExtent: 32,
            scrollController: FixedExtentScrollController(
              initialItem: widget.phoneAngleState,
            ),
            onSelectedItemChanged: (int selectedItem) {
              widget.updatePhoneAngleState(selectedItem);
            },
            children: List<Widget>.generate(phoneAngles.length, (int index) {
              return Center(child: Text(phoneAngles[index]));
            }),
          ),
        );
      },
      child: Text(
        phoneAngles[widget.phoneAngleState],
        style: const TextStyle(
          fontSize: 22.0,
        ),
      ),
    );
  }
}

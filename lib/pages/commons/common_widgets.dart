import 'package:flutter/cupertino.dart';

class CommonWidgets {
  static Widget navBarLeadingButton({
    required BuildContext context,
    required String text,
    required Function() onPressed,
  }) {
    return SizedBox(
      width: 80,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: Row(
          children: <Widget>[
            const Icon(CupertinoIcons.back),
            Text(text),
          ],
        ),
      ),
    );
  }

  static Widget navBarTrailingButton({
    required BuildContext context,
    required String text,
    required Function() onPressed,
  }) {
    return SizedBox(
      width: 80,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }

  static Widget serverUnavailableDialogue({
    required BuildContext context,
    required String msg,
  }) {
    return CupertinoAlertDialog(
      title: const Text(
        'Not Available',
        style: TextStyle(color: CupertinoColors.systemRed),
      ),
      content: Text(msg),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          child: const Text(
            'OK',
            style: TextStyle(color: CupertinoColors.systemBlue),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}

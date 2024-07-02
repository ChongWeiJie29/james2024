import 'package:flutter/cupertino.dart';

class CommonWidgets {

  static Widget navBarLeadingButton(
      BuildContext context, String text, Function() onPressed) {
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

  static Widget navBarTrailingButton(
      BuildContext context, String text, Function() onPressed) {
    return SizedBox(
      width: 80,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
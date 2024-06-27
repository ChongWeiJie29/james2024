import 'package:flutter/cupertino.dart';

class ScanBackButton extends StatelessWidget {
  const ScanBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Row(
          children: <Widget>[
            Icon(CupertinoIcons.back),
            Text('Home'),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';

class SummaryControlPanel extends StatelessWidget {
  const SummaryControlPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        CupertinoButton.filled(
          onPressed: () => Navigator.of(context).pushReplacementNamed('/scan'),
          child: const Text("Next Phone"),
        ),
        CupertinoButton.filled(
          onPressed: () => Navigator.of(context).pushReplacementNamed('/home'),
          child: const Icon(CupertinoIcons.house_fill),
        ),
      ],
    );
  }
}

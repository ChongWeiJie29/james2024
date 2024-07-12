import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../change_notifiers/captured_images_notifiers.dart';

class SummaryControlPanel extends StatelessWidget {
  const SummaryControlPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CapturedImagesNotifiers>(
        builder: (context, capturedImagesNotifier, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 50,
            child: CupertinoButton.filled(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/scan');
                capturedImagesNotifier.clearImages();
              },
              padding: const EdgeInsets.all(10),
              child: const Text('Next Phone'),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 50,
            height: 50,
            child: CupertinoButton.filled(
              alignment: Alignment.center,
              onPressed: () =>
                  Navigator.of(context).pushReplacementNamed('/home'),
              padding: EdgeInsets.zero,
              child: const Icon(CupertinoIcons.house_fill),
            ),
          ),
        ],
      );
    });
  }
}

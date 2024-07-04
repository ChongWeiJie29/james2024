import 'package:flutter/cupertino.dart';
import 'package:james2024/pages/summary/summary_images.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          automaticallyImplyLeading: false,
          middle: Text("Summary"),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SummaryImages(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
            ),
          ],
        ),
      ),
    );
  }
}


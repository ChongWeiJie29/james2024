import 'package:flutter/cupertino.dart';
import 'package:james2024/pages/home/home.dart';
import 'package:james2024/pages/scan/scan.dart';

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
            const Text(
              "Summary Page",
              style: TextStyle(color: CupertinoColors.white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CupertinoButton.filled(
                  onPressed: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const ScanningPage()
                    ),
                  ),
                  child: const Text("Next Phone"),
                ),
                CupertinoButton.filled(
                  onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(builder: (context) => const HomePage()),
                    (r) => false
                  ),
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


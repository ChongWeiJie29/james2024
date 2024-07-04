import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:james2024/pages/summary/summary_control_panel.dart';
import 'package:james2024/pages/summary/summary_images.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<XFile> capturedImages =
        ModalRoute.of(context)!.settings.arguments as List<XFile>;

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
            SummaryImages(capturedImages: capturedImages),
            const SummaryControlPanel(),
          ],
        ),
      ),
    );
  }
}

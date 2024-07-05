import 'package:flutter/cupertino.dart';
import 'package:james2024/change_notifiers/captured_images_notifiers.dart';
import 'package:james2024/pages/summary/summary_control_panel.dart';
import 'package:james2024/pages/summary/summary_images.dart';
import 'package:provider/provider.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CapturedImagesNotifiers>(
        builder: (context, capturedImagesNotifiers, child) {
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
              SummaryImages(
                  capturedImages: capturedImagesNotifiers.capturedImages),
              const SummaryControlPanel(),
            ],
          ),
        ),
      );
    });
  }
}

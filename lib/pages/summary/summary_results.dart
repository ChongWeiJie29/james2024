import 'package:flutter/cupertino.dart';
import 'package:james2024/change_notifiers/decoded_images_notifier.dart';
import 'package:james2024/pages/scan/scan_common.dart';
import 'package:provider/provider.dart';

class SummaryResults extends StatelessWidget {
  const SummaryResults({super.key});

  Widget processResults(List<dynamic> decodedImages) {
    Map<int, int> results = {};
    for (var i = 0; i < decodedImages.length; i++) {
      int count = 0;
      for (var detection in decodedImages[i]) {
        var category = detection['category'];
        count += category == "scratch" ? 1 : 0;
      }
      results[i] = count;
    }
    String resultText = "";
    for (var result in results.entries) {
      resultText += "${phoneAngles[result.key]}: ${result.value} \n";
    }
    return Text(resultText);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DecodedImagesNotifier>(
      builder: (context, decodedImagesNotifier, child) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: CupertinoColors.white,
                  width: 1,
                ),
              ),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 10),
                  const Text(
                    "Results (Scratches)",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  processResults(decodedImagesNotifier.decodedImages),
                ],
              )),
        );
      },
    );
  }
}

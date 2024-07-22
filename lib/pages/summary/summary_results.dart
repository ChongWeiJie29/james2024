import 'package:flutter/cupertino.dart';
import 'package:james2024/change_notifiers/decoded_images_notifier.dart';
import 'package:james2024/pages/scan/scan_common.dart';
import 'package:james2024/pages/summary/model_prediction.dart';
import 'package:provider/provider.dart';

import 'bbox.dart';

class SummaryResults extends StatelessWidget {
  const SummaryResults({super.key});

  Widget processResults(List<ModelPrediction> decodedImages) {
    Map<int, int> results = {};
    for (int i = 0; i < decodedImages.length; i++) {
      int count = 0;
      for (Bbox bbox in decodedImages[i].predictions) {
        count += bbox.category == PredictionType.scratch ? 1 : 0;
      }
      results[i] = count;
    }
    String resultText = "";
    for (MapEntry<int, int> result in results.entries) {
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

import 'package:flutter/cupertino.dart';
import 'package:james2024/change_notifiers/captured_images_notifiers.dart';
import 'package:james2024/change_notifiers/decoded_images_notifier.dart';
import 'package:james2024/pages/summary/summary_card.dart';
import 'package:provider/provider.dart';

class SummaryImages extends StatelessWidget {
  const SummaryImages({super.key});

  // Flutter vision package. Temporary not in use as its rly L.
  // final FlutterVision _vision = FlutterVision();

  // Future<void> initModel() async {
  //   await _vision.loadYoloModel(
  //       labels: 'assets/labels.txt',
  //       modelPath: 'assets/scratch100.tflite',
  //       modelVersion: "yolov8seg",
  //       quantization: false,
  //       numThreads: 1,
  //       useGpu: false);
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer2<CapturedImagesNotifiers, DecodedImagesNotifier>(
      builder:
          (context, capturedImagesNotifiers, decodedImagesNotifier, child) {
        return SizedBox(
          height: 400,
          child: CustomScrollView(
            scrollDirection: Axis.horizontal,
            slivers: <Widget>[
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int i) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: CupertinoColors.white,
                          width: 1,
                        ),
                      ),
                      child: SummaryCard(
                          index: i,
                          // model: _vision,
                          capturedImage:
                              capturedImagesNotifiers.capturedImages[i],
                          decodedImage:
                              decodedImagesNotifier.decodedImages[i]),
                    );
                  },
                  childCount: capturedImagesNotifiers.capturedImages.length,
                ),
              ),
            ],
          ),
        );
        // return SizedBox(
        //   height: 720,
        //   child: ListView.separated(
        //     scrollDirection: Axis.horizontal,
        //     separatorBuilder: (BuildContext context, int index) =>
        //     const SizedBox(
        //       width: 20,
        //     ),
        //     itemCount: capturedImagesNotifiers.capturedImages.length,
        //     itemBuilder: (context, index) {
        //       return SummaryCard(
        //         index: index,
        //         // model: _vision,
        //         capturedImage: capturedImagesNotifiers.capturedImages[index],
        //         decodedImage: decodedImagesNotifier.decodedImages[index]
        //       );
        //     },
        //   ),
        // );
      },
    );
  }
}

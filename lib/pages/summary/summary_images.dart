import 'package:flutter/cupertino.dart';
import 'package:james2024/change_notifiers/captured_images_notifiers.dart';
import 'package:james2024/change_notifiers/decoded_images_notifier.dart';
import 'package:james2024/pages/summary/summary_card.dart';
import 'package:provider/provider.dart';

class SummaryImages extends StatelessWidget {
  const SummaryImages({super.key});

  final double cellHeight = 400;

  @override
  Widget build(BuildContext context) {
    return Consumer2<CapturedImagesNotifiers, DecodedImagesNotifier>(
      builder:
          (context, capturedImagesNotifiers, decodedImagesNotifier, child) {
        return SizedBox(
          height: cellHeight,
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
                            decodedImagesNotifier.decodedImages[i],
                        parentHeight: cellHeight,
                      ),
                    );
                  },
                  childCount: capturedImagesNotifiers.capturedImages.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:james2024/change_notifiers/captured_images_notifiers.dart';
import 'package:james2024/change_notifiers/decoded_images_notifier.dart';
import 'package:james2024/pages/scan/scan_common.dart';
import 'package:james2024/pages/summary/summary_card.dart';
import 'package:provider/provider.dart';

class SummaryImages extends StatelessWidget {
  const SummaryImages({super.key});

  final double cellHeight = 350;
  final int imgCount = 6;

  Widget renderImages(int i, CapturedImagesNotifiers capturedImagesNotifiers, DecodedImagesNotifier decodedImagesNotifier) {
   return SummaryCard(
      index: i,
      capturedImage:
      capturedImagesNotifiers.capturedImages[i],
      decodedImage: decodedImagesNotifier
          .decodedImages[i],
      parentHeight: cellHeight,
    );
  }

  Widget renderEmptyImage() {
    return const Center(
      child: Icon(
        CupertinoIcons.camera,
        size: 50,
        color: CupertinoColors.systemGrey2,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<CapturedImagesNotifiers, DecodedImagesNotifier>(
      builder:
          (context, capturedImagesNotifiers, decodedImagesNotifier, child) {
        int itemCount = capturedImagesNotifiers.capturedImages.length;
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
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        phoneAngles[i],
                        style: const TextStyle(
                          color: CupertinoColors.white,
                          fontSize: 20,
                        ),
                      ),
                      Container(
                        height: cellHeight - 50,
                        width: cellHeight - 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: CupertinoColors.white,
                            width: 1,
                          ),
                        ),
                        child: i < itemCount
                            ? renderImages(i, capturedImagesNotifiers, decodedImagesNotifier)
                            : renderEmptyImage(),
                      ),
                    ],
                  );},
                  childCount: imgCount,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

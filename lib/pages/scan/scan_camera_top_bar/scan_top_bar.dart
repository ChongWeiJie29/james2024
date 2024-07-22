import 'dart:async';
import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:james2024/change_notifiers/captured_images_notifiers.dart';
import 'package:james2024/change_notifiers/decoded_images_notifier.dart';
import 'package:james2024/pages/commons/common_widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ScanTopBar extends StatelessWidget
    implements ObstructingPreferredSizeWidget {
  const ScanTopBar({
    super.key,
    required this.isLoading,
    required this.updateLoadingState,
    required this.updatePhoneAngle,
  });

  final bool isLoading;
  final Function(bool) updateLoadingState;
  final Function(int) updatePhoneAngle;

  @override
  Size get preferredSize =>
      Size.fromHeight(const CupertinoNavigationBar().preferredSize.height);

  @override
  bool shouldFullyObstruct(BuildContext context) => true;

  Future<bool> isServerOnline() async {
    String? apiEndpoint = dotenv.env['API_ENDPOINT'];
    try {
      await get(Uri.parse('$apiEndpoint')).timeout(
        const Duration(seconds: 5),
        onTimeout: () => throw TimeoutException("Server is not responding"),
      );
    } on TimeoutException catch (_) {
      return false;
    }
    return true;
  }

  dynamic sendReq(List<XFile> capturedImages,
      DecodedImagesNotifier decodedImagesNotifier) async {
    String? apiEndpoint = dotenv.env['API_ENDPOINT'];
    MultipartRequest request = MultipartRequest(
      'POST',
      Uri.parse('$apiEndpoint/detect'),
    );
    for (XFile capturedImage in capturedImages) {
      final fixedImagePath =
          await FlutterExifRotation.rotateImage(path: capturedImage.path);
      request.files.add(await MultipartFile.fromPath(
        'images',
        fixedImagePath.path,
        contentType: MediaType('image', 'jpg'),
      ));
    }
    StreamedResponse response = await request.send();
    String responseData = await response.stream.bytesToString();
    decodedImagesNotifier.setDecodedImages(json.decode(responseData));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<CapturedImagesNotifiers, DecodedImagesNotifier>(builder:
        (context, capturedImagesNotifiers, decodedImagesNotifier, child) {
      return CupertinoNavigationBar(
        padding: const EdgeInsetsDirectional.all(0),
        leading: CupertinoNavigationBarBackButton(
          previousPageTitle: "Home",
          onPressed: () => Navigator.pop(context),
        ),
        middle: const Text(
          'Scan',
          style: TextStyle(fontSize: 20),
        ),
        trailing: SizedBox(
          width: 80,
          child: isLoading
              ? const CupertinoActivityIndicator(
                  color: CupertinoColors.activeBlue,
                )
              : CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () async {
                    updateLoadingState(true);
                    if (!await isServerOnline() && context.mounted) {
                      showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return CommonWidgets.serverUnavailableDialogue(
                            context: context,
                            msg: "Backend server is not running, please contact the developers.",
                          );
                        });
                      updateLoadingState(false);
                      updatePhoneAngle(0);
                      return;
                    }
                    await sendReq(capturedImagesNotifiers.capturedImages,
                        decodedImagesNotifier);
                    updateLoadingState(false);
                    updatePhoneAngle(0);
                    if (context.mounted) {
                      Navigator.pushNamed(context, '/summary');
                    }
                  },
                  child: const Text("Done"),
                ),
        ),
      );
    });
  }
}

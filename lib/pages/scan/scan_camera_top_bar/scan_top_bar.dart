import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:james2024/change_notifiers/captured_images_notifiers.dart';
import 'package:james2024/change_notifiers/decoded_images_notifier.dart';
import 'package:james2024/pages/commons/common_widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ScanTopBar extends StatelessWidget
    implements ObstructingPreferredSizeWidget {
  const ScanTopBar({super.key});

  @override
  Size get preferredSize =>
      Size.fromHeight(const CupertinoNavigationBar().preferredSize.height);

  @override
  bool shouldFullyObstruct(BuildContext context) => true;

  // Prepare and send list of xfiles to python flask backend
  sendReq(List<XFile> capturedImages,
      DecodedImagesNotifier decodedImagesNotifier) async {
    var apiEndpoint = dotenv.env['API_ENDPOINT'];
    var request = http.MultipartRequest(
      'POST',
      // 10.0.2.2 on the emulator reroutes to the computer's
      // local host - 127.0.0.1.
      Uri.parse('$apiEndpoint/detect'),
    );

    for (XFile capturedImage in capturedImages) {
      final fixedImagePath =
          await FlutterExifRotation.rotateImage(path: capturedImage.path);
      request.files.add(await http.MultipartFile.fromPath(
        'images',
        fixedImagePath.path,
        contentType: MediaType('image', 'jpg'),
      ));
    }

    var response = await request.send();
    var responseData = await response.stream.bytesToString();
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
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          middle: const Text(
            'Scan',
            style: TextStyle(fontSize: 20),
          ),
          trailing: CommonWidgets.navBarTrailingButton(
            context: context,
            text: 'Done',
            onPressed: () async {
              await sendReq(capturedImagesNotifiers.capturedImages,
                  decodedImagesNotifier);
              if (context.mounted) {
                Navigator.pushNamed(context, '/summary');
              }
            },
          ));
    });
  }
}

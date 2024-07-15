import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:james2024/change_notifiers/camera_notifier.dart';
import 'package:james2024/change_notifiers/captured_images_notifiers.dart';
import 'package:james2024/change_notifiers/decoded_images_notifier.dart';
import 'package:james2024/pages/guide/user_guide.dart';
import 'package:james2024/pages/home/home.dart';
import 'package:james2024/pages/scan/scan.dart';
import 'package:james2024/pages/summary/summary.dart';
import 'package:james2024/pages/test_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();

  final cameraList = await availableCameras();
  final CameraDescription camera = cameraList.firstWhere(
      (description) => description.lensDirection == CameraLensDirection.back);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => CameraNotifier()),
      ChangeNotifierProvider(create: (context) => CapturedImagesNotifiers()),
      ChangeNotifierProvider(create: (context) => DecodedImagesNotifier()),
    ],
    child: MyApp(camera: camera),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.camera});

  final CameraDescription camera;

  @override
  Widget build(BuildContext context) {
    Brightness platformBrightness = MediaQuery.of(context).platformBrightness;
    return Consumer<CameraNotifier>(
      builder: (context, cameraNotifier, child) {
        cameraNotifier.setCamera(camera);
        return CupertinoApp(
          debugShowCheckedModeBanner: false,
          theme: CupertinoThemeData(brightness: platformBrightness),
          home: const HomePage(),
          routes: {
            '/home': (context) => const HomePage(),
            '/scan': (context) => const ScanningPage(),
            '/summary': (context) => const SummaryPage(),
            '/test': (context) => const TestPage(),
            '/guide': (context) => const UserGuide(),
          }
        );
      },
    );
  }
}

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:james2024/change_notifiers/camera_notifier.dart';
import 'package:james2024/pages/home/home.dart';
import 'package:james2024/pages/scan/scan.dart';
import 'package:james2024/pages/summary/summary.dart';
import 'package:james2024/pages/test_page.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cameraList = await availableCameras();
  final CameraDescription camera = cameraList.firstWhere(
      (description) => description.lensDirection == CameraLensDirection.back);

  runApp(MyApp(camera: camera));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.camera});

  final CameraDescription camera;

  @override
  Widget build(BuildContext context) {
    Brightness platformBrightness = MediaQuery.of(context).platformBrightness;
    return ChangeNotifierProvider(
        create: (context) => CameraNotifier(),
        child: CupertinoApp(
            debugShowCheckedModeBanner: false,
            theme: CupertinoThemeData(brightness: platformBrightness),
            home: HomePage(camera: camera),
            routes: {
              '/home': (context) => HomePage(camera: camera),
              '/scan': (context) => const ScanningPage(),
              '/summary': (context) => const SummaryPage(),
              '/test': (context) => const TestPage(),
            }));
  }
}

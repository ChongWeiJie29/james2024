import 'package:flutter/cupertino.dart';
import 'package:james2024/pages/home/home.dart';
import 'package:james2024/pages/scan/scan.dart';
import 'package:james2024/pages/summary/summary.dart';
import 'package:james2024/pages/test_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Brightness platformBrightness = MediaQuery.of(context).platformBrightness;

    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(brightness: platformBrightness),
      home: const HomePage(),
      routes: {
        '/home': (context) => const HomePage(),
        '/scan': (context) => const ScanningPage(),
        '/summary': (context) => const SummaryPage(),
        '/test': (context) => const TestPage(),
      }
    );
  }
}

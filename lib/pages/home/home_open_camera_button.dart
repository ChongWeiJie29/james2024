import 'package:flutter/cupertino.dart';
import 'package:james2024/pages/scan/scan.dart';

class HomeOpenCameraButton extends StatelessWidget {
  const HomeOpenCameraButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton.filled(
      onPressed: () {
        Navigator.pushNamed(context, '/scan',
      },
      child: const Text(
        'Open Camera',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

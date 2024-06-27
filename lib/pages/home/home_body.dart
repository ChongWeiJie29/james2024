import 'package:flutter/cupertino.dart';
import 'package:james2024/pages/home/home_open_camera_button.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Start Scanning',
            style: TextStyle(fontSize: 40),
          ),
          SizedBox(height: 80),
          HomeOpenCameraButton(),
        ],
      ),
    );
  }
}

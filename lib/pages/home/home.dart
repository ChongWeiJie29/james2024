import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:james2024/change_notifiers/camera_notifier.dart';
import 'package:james2024/pages/home/home_body.dart';
import 'package:james2024/pages/home/home_top_bar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.camera});

  final CameraDescription camera;

  @override
  Widget build(BuildContext context) {
    return Consumer<CameraNotifier>(builder: (context, cameraNotifer, child) {
      cameraNotifer.setCamera(camera);
      return const PopScope(
        canPop: false,
        child: CupertinoPageScaffold(
          navigationBar: HomeTopBar(),
          child: HomeBody(),
        ),
      );
    });
  }
}

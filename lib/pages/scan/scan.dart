import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:james2024/pages/scan/scan_top_bar.dart';

class ScanningPage extends StatefulWidget {
  const ScanningPage({super.key});

  @override
  State<ScanningPage> createState() => _ScanningPageState();
}

class _ScanningPageState extends State<ScanningPage> {
  late List<CameraDescription> _cameras;
  late CameraController _controller;
  var _isReady = false;

  @override
  void initState() {
    super.initState();
    _setUpCamera();
  }

  void _setUpCamera() async {
    try {
      // initialize cameras
      _cameras = await availableCameras();
      // initialize camera controllers
      // Current bug for high/medium with Samsung devices
      _controller = CameraController(
          _cameras.firstWhere((description) =>
              description.lensDirection == CameraLensDirection.back),
          ResolutionPreset.medium);
      await _controller.initialize();
    } on CameraException catch (_) {
      // do something on error
    }

    if (mounted) setState(() => _isReady = true);
  }

  /* ---------------------------------------------------------------------------- */
  Widget cameraWindow() {
    final size = MediaQuery.of(context).size;
    var flag = !_isReady || !_controller.value.isInitialized;

    return Container(
      decoration: flag ? const BoxDecoration(color: Colors.white) : null,
      width: size.width,
      height: size.height * 0.9,
      child: flag
          ? const Center(
              child: SizedBox(
                width: 25,
                height: 25,
                child: CircularProgressIndicator(strokeWidth: 3),
              ),
            )
          : ClipRRect(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: CameraPreview(_controller),
              ),
            ),
    );
  }

  Widget cameraCaptureButton() {
    return Material(
      shape: const CircleBorder(),
      child: SizedBox(
        width: 60,
        height: 60,
        child: InkWell(
          onTap: () async {
            try {
              final image = await _controller.takePicture();
              print('Picture saved to ${image.path}');
            } on CameraException catch (_) {
              // do something on error
            }
          },
          child: const Icon(
            CupertinoIcons.camera,
            size: 30,
          ),
        ),
      ),
    );
  }

  Widget cameraControls() {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          cameraCaptureButton(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const ScanTopBar(),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        cameraWindow(),
        cameraControls(),
      ]),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:james2024/pages/commons/common_widgets.dart';

class HomeOpenCameraButton extends StatefulWidget {
  const HomeOpenCameraButton({super.key});

  final serverUnavailableDialogue = CommonWidgets.serverUnavailableDialogue;

  @override
  State<HomeOpenCameraButton> createState() => _HomeOpenCameraButtonState();
}

class _HomeOpenCameraButtonState extends State<HomeOpenCameraButton> {
  bool _isLoading = false;

  get _serverUnavailableDialogue => widget.serverUnavailableDialogue;

  dynamic checkServerStatus(BuildContext context) async {
    var apiEndpoint = dotenv.env['API_ENDPOINT'];
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await get(Uri.parse('$apiEndpoint'))
          .timeout(const Duration(seconds: 5), onTimeout: () {
        throw ClientException(
            "Backend server is not running, please contact the developers.");
      });
      if (response.statusCode != 200) {
        throw ClientException(
            "There is an issue with the Server, please contact the developers.");
      }
      if (!context.mounted) {
        return;
      }
      Navigator.pushNamed(context, '/scan');
    } on ClientException catch (e) {
      showCupertinoDialog(
          context: context,
          builder: (context) {
            return _serverUnavailableDialogue(context: context, msg: e.message);
          });
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 50,
      child: CupertinoButton.filled(
        padding: EdgeInsets.zero,
        disabledColor: CupertinoColors.activeBlue,
        onPressed: _isLoading ? null : () => checkServerStatus(context),
        child: _isLoading
            ? const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Pinging Servers',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(width: 10),
                  CupertinoActivityIndicator(
                    color: CupertinoColors.black,
                  ),
                ],
              )
            : const Text(
                'Open Camera',
                style: TextStyle(fontSize: 20),
              ),
      ),
    );
  }
}

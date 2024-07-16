import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

class HomeOpenCameraButton extends StatefulWidget {
  const HomeOpenCameraButton({super.key});

  @override
  State<HomeOpenCameraButton> createState() => _HomeOpenCameraButtonState();
}

class _HomeOpenCameraButtonState extends State<HomeOpenCameraButton> {
  bool _isLoading = false;

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
      if (!context.mounted) {
        return;
      }
      Navigator.pushNamed(context, '/scan');
      if (response.statusCode != 200) {
        throw ClientException(
            "There is an issue with the Server, please contact the developers.");
      }
    } on ClientException catch (e) {
      showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: const Text(
                'Not Available',
                style: TextStyle(color: CupertinoColors.systemRed),
              ),
              content: Text(
                e.message,
              ),
              actions: <CupertinoDialogAction>[
                CupertinoDialogAction(
                  child: const Text(
                    'OK',
                    style: TextStyle(color: CupertinoColors.systemBlue),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
          });
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton.filled(
      disabledColor: CupertinoColors.activeBlue,
      onPressed: _isLoading ? null : () => checkServerStatus(context),
      child: _isLoading
          ? Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: CupertinoColors.white,
                  width: 2,
                ),
              ),
            child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Pinging Server...',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(width: 10),
                  CupertinoActivityIndicator(
                    color: CupertinoColors.black,
                    radius: 12,
                  ),
                ],
              ),
          )
          : const Text(
              'Open Camera',
              style: TextStyle(fontSize: 20),
            ),
    );
  }
}

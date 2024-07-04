import 'package:flutter/cupertino.dart';
import 'package:james2024/change_notifiers/captured_images_notifiers.dart';
import 'package:james2024/pages/commons/common_widgets.dart';
import 'package:provider/provider.dart';

class ScanTopBar extends StatelessWidget
    implements ObstructingPreferredSizeWidget {
  const ScanTopBar({super.key});

  @override
  Size get preferredSize =>
      Size.fromHeight(const CupertinoNavigationBar().preferredSize.height);

  @override
  bool shouldFullyObstruct(BuildContext context) => true;

  @override
  Widget build(BuildContext context) {
    return Consumer<CapturedImagesNotifiers>(
        builder: (context, capturedImagesNotifiers, child) {
      return CupertinoNavigationBar(
          padding: const EdgeInsetsDirectional.all(0),
          leading: CommonWidgets.navBarLeadingButton(
            context,
            "Back",
            () => Navigator.pop(context),
          ),
          middle: const Text(
            'Scanning',
            style: TextStyle(fontSize: 20),
          ),
          trailing: CommonWidgets.navBarTrailingButton(
            context,
            'Done',
            () => Navigator.pushNamed(context, '/summary',
                arguments: capturedImagesNotifiers.capturedImages),
          ));
    });
  }
}

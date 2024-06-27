import 'package:flutter/cupertino.dart';
import 'package:james2024/pages/scan/scan_back_button.dart';

class ScanTopBar extends StatelessWidget
    implements ObstructingPreferredSizeWidget {
  const ScanTopBar({super.key});

  @override
  Size get preferredSize =>
      Size.fromHeight(const CupertinoNavigationBar().preferredSize.height);

  @override
  bool shouldFullyObstruct(BuildContext context) => false;

  @override
  Widget build(BuildContext context) {
    return const CupertinoNavigationBar(
      padding: EdgeInsetsDirectional.all(0),
      leading: ScanBackButton(),
      middle: Text(
        'Scanning',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';

class UserGuideNavBar extends StatelessWidget
    implements ObstructingPreferredSizeWidget {
  const UserGuideNavBar({super.key});

  @override
  Size get preferredSize =>
      Size.fromHeight(const CupertinoNavigationBar().preferredSize.height);

  @override
  bool shouldFullyObstruct(BuildContext context) => true;

  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBar(
      padding: const EdgeInsetsDirectional.all(0),
      leading: CupertinoNavigationBarBackButton(
        previousPageTitle: "Home",
        onPressed: () => Navigator.pop(context),
      ),
      middle: const Text("User Guide", style: TextStyle(fontSize: 20)),
    );
  }
}

import 'package:flutter/cupertino.dart';

class HomeTopBar extends StatelessWidget
    implements ObstructingPreferredSizeWidget {
  const HomeTopBar({super.key});

  @override
  Size get preferredSize =>
      Size.fromHeight(const CupertinoNavigationBar().preferredSize.height);

  @override
  bool shouldFullyObstruct(BuildContext context) => true;

  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBar(
      leading: SizedBox(
        width: 60,
        child: CupertinoContextMenuAction(
          onPressed: () {
            // TODO: Implement this action.
          },
          child: const Icon(CupertinoIcons.list_bullet),
        ),
      ),
      middle: const Text("JAMES", style: TextStyle(fontSize: 20)),
    );
  }
}

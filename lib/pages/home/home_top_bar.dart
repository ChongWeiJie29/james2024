import 'package:flutter/cupertino.dart';

class HomeTopBar extends StatelessWidget
    implements ObstructingPreferredSizeWidget {
  const HomeTopBar({super.key});

  @override
  Size get preferredSize =>
      Size.fromHeight(const CupertinoNavigationBar().preferredSize.height);

  @override
  bool shouldFullyObstruct(BuildContext context) => true;

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text("Main Menu"),
        message: const Text("Select a page to jump to"),
        actions: <CupertinoActionSheetAction>[
          // CupertinoActionSheetAction(
          //   onPressed: () => Navigator.pushNamed(
          //     context,
          //     '/summary',
          //   ),
          //   child: const Text("Summary Page"),
          // ),
          // CupertinoActionSheetAction(
          //   onPressed: () => Navigator.pushNamed(
          //     context,
          //     '/test',
          //   ),
          //   child: const Text("Test Page"),
          // ),
          CupertinoActionSheetAction(
            onPressed: () => Navigator.pushNamed(
              context,
              '/guide',
            ),
            child: const Text("User Guide"),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBar(
      leading: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () => _showActionSheet(context),
        child: const Icon(CupertinoIcons.list_bullet),
      ),
      middle: const Text("JAMES", style: TextStyle(fontSize: 20)),
    );
  }
}

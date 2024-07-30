import 'package:flutter/cupertino.dart';
import 'package:james2024/pages/guide/user_guide_body.dart';
import 'package:james2024/pages/guide/user_guide_navbar.dart';

class UserGuide extends StatelessWidget {
  const UserGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: UserGuideNavBar(),
      child: UserGuideBody(),
    );
  }
}

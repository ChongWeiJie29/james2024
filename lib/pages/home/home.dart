import 'package:flutter/cupertino.dart';
import 'package:james2024/pages/home/home_body.dart';
import 'package:james2024/pages/home/home_top_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: HomeTopBar(),
      child: HomeBody(),
    );
  }
}

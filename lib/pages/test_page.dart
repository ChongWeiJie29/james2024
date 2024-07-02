import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  static List<XFile> images = [];

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {

  void _addImage(String path) {
    setState(() {
      TestPage.images.add(XFile(path));
    });
  }

  @override
  void initState() {
    super.initState();
    _addImage("assets/images/20240619_161942.jpg");
    _addImage("assets/images/20240619_162125.jpg");
    _addImage("assets/images/20240619_162137.jpg");
    _addImage("assets/images/20240619_162201.jpg");
    _addImage("assets/images/20240619_162223.jpg");
  }

  @override
  Widget build(BuildContext context) {

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Test Page'),
      ),
      child: Container(
        margin: const EdgeInsets.only(top: 50),
        height: 300,
        child: CustomScrollView(
          scrollDirection: Axis.horizontal,
          slivers: <Widget>[
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
              ),
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                return Container(
                  padding: const EdgeInsets.all(8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image(
                      image: Image.asset(TestPage.images[index].path).image,
                      fit: BoxFit.cover,
                      height: 300,
                      width: 300,
                    ),
                  ),
                );
              },
              childCount: TestPage.images.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

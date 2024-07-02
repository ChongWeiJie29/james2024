import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';

class SummaryImages extends StatefulWidget {
  const SummaryImages({super.key});

  @override
  State<SummaryImages> createState() => _SummaryImagesState();
}

class _SummaryImagesState extends State<SummaryImages> {
  List<XFile> images = [];

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  void addImages(XFile image) {
    setState(() {
      images.add(image);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: CupertinoColors.white,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
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
                      image: Image.asset(images[index].path).image,
                      fit: BoxFit.cover,
                      height: 300,
                      width: 300,
                    ),
                  ),
                );
              },
              childCount: images.length,
            ),
          ),
        ],
      ),
    );
  }
}

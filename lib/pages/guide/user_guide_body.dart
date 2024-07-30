import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/services.dart' show rootBundle;

class UserGuideBody extends StatefulWidget {
  const UserGuideBody({super.key});

  @override
  State<UserGuideBody> createState() => _UserGuideBodyState();
}

class _UserGuideBodyState extends State<UserGuideBody> {
  late ScrollController _scroller;

  @override
  void initState() {
    super.initState();
    _scroller = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _scroller.dispose();
  }

  Future<String> _readFile(String path) async {
    try {
      final String out = await rootBundle.loadString(path);
      return out;
    } catch (e) {
      return "Error reading file: $e";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        FutureBuilder<String>(
            future: _readFile("assets/guide.md"),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                return Markdown(
                  styleSheetTheme: MarkdownStyleSheetBaseTheme.cupertino,
                  data: snapshot.data!,
                  controller: _scroller,
                );
              } else {
                return const Center(child: Text('No content available'));
              }
            }),
        Padding(
          padding: const EdgeInsets.all(16),
          child: FloatingActionButton(
            onPressed: () {
              print("FloatingActionButton pressed");
              // Implement easter egg and scroll to top
              // Click 7 times in a row to reveal the easter egg
            },
            backgroundColor: CupertinoColors.systemBlue,
            shape: const CircleBorder(),
            child: const Icon(
              Icons.keyboard_arrow_up_outlined,
              color: CupertinoColors.white,
            ),
          ),
        ),
      ],
    );
  }
}

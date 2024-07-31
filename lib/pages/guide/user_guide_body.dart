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
  int _count = 0;

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
                return CupertinoScrollbar(
                  thumbVisibility: true,
                  controller: _scroller,
                  child: Markdown(
                    styleSheet: MarkdownStyleSheet.fromTheme(
                      ThemeData(
                        textTheme: const TextTheme(
                          headlineSmall: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: CupertinoColors.systemBlue,
                          ),
                          titleLarge: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: CupertinoColors.systemBlue,
                          ),
                          bodyMedium: TextStyle(
                            fontSize: 18,
                            color: CupertinoColors.white,
                          ),
                        ),
                      ),
                    ),
                    styleSheetTheme: MarkdownStyleSheetBaseTheme.cupertino,
                    data: snapshot.data!,
                    controller: _scroller,
                  ),
                );
              } else {
                return const Center(child: Text('No content available'));
              }
            }),
        Padding(
          padding:
              const EdgeInsets.only(right: 16, bottom: 5, left: 16, top: 16),
          child: FloatingActionButton(
            onPressed: () {
              _scroller.animateTo(
                _scroller.position.minScrollExtent,
                curve: Curves.easeOut,
                duration: const Duration(milliseconds: 500),
              );
              // Implement easter egg and scroll to top
              // Click 7 times in a row to reveal the easter egg
              if (++_count >= 3) {
                _count = 0;
                showCupertinoDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: const Text("Easter Egg"),
                      content: const Text(
                          "Congratulations! You found the easter egg!"),
                      actions: [
                        CupertinoDialogAction(
                          child: const Text("Close"),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    );
                  },
                );
              }
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

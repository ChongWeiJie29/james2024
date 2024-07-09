import 'package:flutter/cupertino.dart';

class SummaryResults extends StatelessWidget {
  const SummaryResults({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: CupertinoColors.white,
          width: 1,
        ),
      ),
      child: const Column(
        children: <Widget>[
          SizedBox(height: 10),
          Text(
            "Results",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "The results are in! You have been diagnosed with a severe case of the common cold. Please take the following steps to ensure a speedy recovery.",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      )
    );
  }
}

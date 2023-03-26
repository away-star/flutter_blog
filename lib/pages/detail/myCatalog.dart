import 'package:flutter/material.dart';

class MyCatalog extends StatelessWidget {
  final String markdown;

  MyCatalog({required this.markdown});

  @override
  Widget build(BuildContext context) {
    List<String> headings = [];
    List<int> levels = [];

    RegExp exp = RegExp(r'^#+\s+(.*)$');
    for (String line in markdown.split('\n')) {
      RegExpMatch? match = exp.firstMatch(line);
      if (match != null) {
        String heading = match.group(1)!;
        int level = match.group(0)!.length;
        headings.add(heading);
        levels.add(level);
      }
    }

    List<Widget> toc = [];
    for (int i = 0; i < headings.length; i++) {
      toc.add(
        SizedBox(height: 8),
      );
      toc.add(
        Text(
          '${'  ' * (levels[i] - 1)}${i + 1}. ${headings[i]}',
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: toc,
    );
  }
}
import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';

class MarkdownPage extends StatelessWidget {
  final String data;
  final tocController;


  MarkdownPage({required this.data, required this.tocController});

  @override
  Widget build(BuildContext context) => buildMarkdown();

  Widget buildMarkdown() => Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: MarkdownGenerator(
          //linesMargin: EdgeInsets.all(0),
            config:MarkdownConfig(
                configs: [
                  LinkConfig(
                    style: TextStyle(
                      color: Colors.blue[650]??Colors.blue[200],
                      decoration: TextDecoration.underline,
                    ),
                    onTap: (url) {
                      ///TODO:on tap
                    },
                  ),
                  PreConfig(textStyle: TextStyle(fontSize: 12)),

                ]
            )
        ).buildWidgets(
          data,
        ),
      );
}

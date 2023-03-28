import 'package:flutter/material.dart';
import 'package:markdown_widget/config/toc.dart';

class MdToc extends StatelessWidget {
  final tocController;
  const MdToc({Key? key, required this.tocController}) : super(key: key);

  @override
  Widget build(BuildContext context) =>buildTocWidget();

  Widget buildTocWidget() => TocWidget(controller: tocController);
}

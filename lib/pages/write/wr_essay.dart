import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WritePage extends StatefulWidget {
  @override
  _WritePageState createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('写文章'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _textEditingController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: '请在此处输入文章内容',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.image),
                  onPressed: () {
                    // 插入图片的操作
                  },
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // 提交文章的操作
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

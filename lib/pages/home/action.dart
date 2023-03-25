import 'package:flutter/material.dart';

class MyAction extends StatelessWidget {
  const MyAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.notifications, color: Colors.black),
      onPressed: () {
        // TODO: 处理通知逻辑
      },
    );
  }
}

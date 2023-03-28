import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../common/constants.dart';

class BottomInfo extends StatelessWidget {
  const BottomInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Row(
        children: [
          const Text(
            "作者掘金地址:",
            style: TextStyle(fontSize: 9, color: Colors.black38),
          ),
          SizedBox(width: 10),
          Expanded(
            child: GestureDetector(
              onTap: () {
                launchUrlString(juejinAddr);
              },
              child: Text(
                juejinAddr,
                style: TextStyle(fontSize: 12, color: Colors.blue[200]),
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 5),
      Row(
        children: [
          const Text(
            "作者csdn地址:",
            style: TextStyle(fontSize: 9, color: Colors.black38),
          ),
          SizedBox(width: 10),
          Expanded(
            child: GestureDetector(
              onTap: () {
                launchUrlString(csdnAddr);
              },
              child: Text(
                csdnAddr,
                style: TextStyle(fontSize: 12, color: Colors.blue[200]),
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 10),
      Row(
        children: [
          Expanded(
            child: const Text(
              "如果觉得文章对你有帮助，欢迎点赞或者分享给有需要的人！",
              style: TextStyle(fontSize: 12, color: Colors.black38),
            ),
          ),
        ],
      ),

    ]);
  }
}

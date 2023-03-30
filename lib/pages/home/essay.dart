import 'dart:math';
import 'package:flutter/material.dart';
import 'package:my_blog/pages/home/data.dart';

class Post_essay {
  Post_essay(
      {required this.author,
      required this.publishTime,
      required this.content,
      required this.images});

  final String author;
  final String publishTime;
  final String content;
  final List<String> images;
}

class essayListPage extends StatelessWidget {
  final List<Post_essay> posts;

  // final List<Post_essay> posts;
  essayListPage({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 随笔列表
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final post = this.posts[index];

          return Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // 作者名字和发布时间
                Row(
                  children: <Widget>[
                    // CircleAvatar(
                    //   backgroundImage: NetworkImage(
                    //       'https://example.com/avatar.jpg'), // 这里可以使用你自己的头像图片 URL
                    // ),
                    // SizedBox(width: 8),
                    Text(
                      "Edited by " + post.author,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(child: SizedBox()),
                    Text(post.publishTime,
                        style:
                            TextStyle(fontSize: 14, color: Colors.grey[600])),
                  ],
                ),

                // 随笔内容
                SizedBox(height: 8),
                Text(post.content),

                // 随笔图片
                GridView.builder(
                  shrinkWrap: true,
                  // 解决无限高度问题
                  physics: ClampingScrollPhysics(),
                  // 禁止滚动
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 每行最多显示 3 张图片
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                    // childAspectRatio: 1,
                  ),
                  itemCount: post.images.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Image.network(
                      post.images[index],
                      fit: BoxFit.cover,
                    );
                  },
                ),
                Divider(
                  height: 32,
                  thickness: 2,
                )
              ],
            ),
          );
        },
        childCount: this.posts.length,
      ),
    );
  }
}

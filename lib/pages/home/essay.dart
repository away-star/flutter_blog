import 'dart:math';

import 'package:flutter/material.dart';

class Post_essay {
  Post_essay({required this.author, required this.publishTime, required this.content, required this.images});

  final String author;
  final String publishTime;
  final String content;
  final List<String> images;
}

List<Post_essay> generatePosts(int count) {
  Random random = Random();
  List<String> imageUrls = [

  ];
  List<Post_essay> posts = [];

  for (int i = 0; i < count; i++) {
    int randomImageCount = random.nextInt(5) + 1;
    List<String> images = List.generate(
      randomImageCount,
          (index) => 'https://www.itying.com/images/flutter/1.png'
    );
    Post_essay post = Post_essay(
      author: "作者 ${i + 1}",
      publishTime: "${random.nextInt(24)}小时前",
      content: "這是第 ${i + 1} 条帖子，随机生成的内容",
      images: images,
    );
    posts.add(post);
  }

  return posts;
}

var _posts = generatePosts(10);

class essayListPage extends StatelessWidget {
  // final List<Post_essay> posts;
  const essayListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 随笔列表
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final post = _posts[index];

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
                        Text("Edited by " + post.author, style: TextStyle(fontWeight: FontWeight.bold),),
    Expanded(child: SizedBox()),
                        Text(post.publishTime,
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[600])),

                  ],
                ),

                // 随笔内容
                SizedBox(height: 8),
                Text(post.content),

                // 随笔图片
                GridView.builder(
                  shrinkWrap: true, // 解决无限高度问题
                  physics: ClampingScrollPhysics(), // 禁止滚动
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
        childCount: _posts.length,
      ),
    );
  }
}

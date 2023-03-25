import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Post {
  final String title;
  final String content;
  final String author;
  final String date;
  final String tag;
  final String image;

  const Post({
    required this.title,
    required this.content,
    required this.author,
    required this.date,
    required this.tag,
    required this.image,
  });
}

class PostList extends StatelessWidget {
  final List<Post> posts;

  const PostList({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(height: 10.0, color: Colors.grey),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: CachedNetworkImage(
                    imageUrl: 'https://picsum.photos/seed/${index + 1}/600/400',
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  '文章标题',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  '文章内容',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                  //通过以下设置让它只显示3行
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                // myMarkdown(markdown: "markdown"),
                SizedBox(height: 10.0),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/avatar.jpg',
                      height: 16.0,
                    ),
                    SizedBox(width: 5.0),
                    Text(
                      '12 Comments',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        //childCount: posts.length,
        childCount: 20, //测试用
      ),
    );
  }
}

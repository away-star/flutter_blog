import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_blog/pages/detail/MyMD.dart';
import 'package:my_blog/pages/detail/detail.dart';

class Post {
  final String title;
  final String content;
  final String author;
  final String date;
  final String tag;           // 分类
  final String image;
  final String thume_up_num; // 点赞数量
  final String id;

  const Post({
    required this.title,
    required this.content,
    required this.author,
    required this.date,
    required this.tag,
    required this.image,
    required this.thume_up_num,
    required this.id,
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
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  // MaterialPageRoute(
                  //   builder: (context) => ArticleDetailPage(
                  //     title: '文章标题',
                  //     content: posts[0].content,
                  //   ),
                  // ),
                  MaterialPageRoute(
                    builder: (context) => ArticleDetailPage(
                      title: posts[index].title,
                      content: posts[index].content,
                      author: posts[index].author,
                      date: posts[index].date,
                      tag: posts[index].tag,
                      image: posts[index].image,
                      thume_up_num: posts[index].thume_up_num,
                      id: posts[index].id,
                    ),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: Colors.grey[300],
                    thickness: 1,
                  ),
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
                      //!?? SVG这里格式会报错？
                      //!这里不是svg格式，可以加载？
                      // SvgPicture.asset(
                      //   'assets/images/avatar.jpg',
                      //   width: 20.0,
                      //   height: 20.0,
                      // ),
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
            ),
          );
        },
        //childCount: posts.length,
        childCount: 20, //测试用
      ),
    );
  }
}

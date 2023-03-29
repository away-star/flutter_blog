import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:my_blog/pages/detail/MyMD.dart';
import 'package:my_blog/pages/detail/mdToc.dart';
import 'bottomInfo.dart';

class ArticleDetailPage extends StatelessWidget {
  final String title;
  final String content;
  final String author;
  final String date;
  final String tag; // 分类
  final String image;
  final String thume_up_num; // 点赞数量
  final List<String> comments; // 评论
  final String id;

  final tocController = TocController();

  ArticleDetailPage({
    required this.title,
    required this.content,
    required this.author,
    required this.date,
    required this.tag,
    required this.image,
    required this.thume_up_num,
    required this.comments,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(title),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.share, color: Colors.black),
              onPressed: () {
                // add share functionality here

              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("${this.title}",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(width: 8),
                    Icon(Icons.thumb_up, color: Colors.grey[500], size: 16),

                    SizedBox(width: 5),
                    Text(
                      this.thume_up_num,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                    ),
                    SizedBox(width: 20),
                    Icon(Icons.edit_calendar,
                        color: Colors.grey[500], size: 16),
                    SizedBox(width: 5),
                    Text(
                      this.date,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                    ),
                    //! 使用expaned组件向右挤压
                    Expanded(
                        child: SizedBox(
                      height: 10,
                    )),
                    Icon(Icons.category, color: Colors.grey[500], size: 16),
                    SizedBox(width: 5),
                    Text(
                      this.tag,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://picsum.photos/seed/${this.image}/600/400',
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                SizedBox(height: 20),
                //MdToc(tocController: tocController,),
                //MyCatalog(markdown: content),
                MarkdownPage(data: this.content, tocController: tocController),

                Divider(
                  color: Colors.black12,
                  height: 50,
                  thickness: 1,
                  indent: 0,
                  endIndent: 0,
                ),

                //! 添加评论
                Row(
                  children: [
                    Icon(Icons.comment, color: Colors.grey[500], size: 20),
                    SizedBox(width: 5),
                    Text(
                      "评论",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                // ListView(
                //   children: [
                //     Text("haha"),
                //   ],
                // ),
                Column(
                  children: [
                    for (var i = 0; i < this.comments.length; i++)
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.person, color: Colors.grey[500]),
                                SizedBox(width: 5),
                                Text(
                                  "匿名用户",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[500],
                                  ),
                                ),
                                Expanded(
                                    child: SizedBox(
                                  height: 10,
                                )),
                                Icon(Icons.edit_calendar,
                                    color: Colors.grey[500], size: 16),
                                SizedBox(width: 5),
                                Text(
                                  "2021-09-09",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(this.comments[i]),
                          ],
                        ),
                      ),
                  ],
                ),
                Divider(
                  color: Colors.black12,
                  height: 50,
                  thickness: 1,
                  indent: 0,
                  endIndent: 0,
                ),
                BottomInfo(),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print(tocController.tocList);
          },
          child: Icon(Icons.menu),
        ));
  }
}

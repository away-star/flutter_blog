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
                Text("spring cloud 与flutter完美对接",
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
                    )
                  ],
                ),
                SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: CachedNetworkImage(
                    imageUrl: 'https://picsum.photos/seed/${this.image}/600/400',
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

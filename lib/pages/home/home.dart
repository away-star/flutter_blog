import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_blog/pages/home/action.dart';
import 'package:my_blog/pages/home/head.dart';
import 'package:my_blog/pages/home/postList.dart';
import 'package:my_blog/pages/home/slideShow.dart';
import 'package:my_blog/services/homeAPI.dart';
import 'package:my_blog/pages/home/essay.dart';
import 'dart:math';
import 'package:my_blog/pages/home/data.dart';
import 'package:my_blog/pages/write/wr_essay.dart';

import '../../utils/APIUtil.dart';

class Home extends StatefulWidget {
  bool check = true;

  Home({Key? key, this.check = true}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  // bool _isLoading = true;
  bool _isLoading = false;
  Map<String, dynamic> _data = {};
  late TabController _tabController;
  // late List<String> _tags;

  final List<String> _tags = [
    "home",
    "spring boot",
    "spring cloud",
    "react",
    "umi.js",
    "H5",
    "flutter",
    "CSS3",
    "Music",
    "Entertainment"
  ];

  @override
  void initState() {
    super.initState();
    fetchData();
    // posts = generatePosts(); //初始化生成数据
    // print(posts);
    print("我被执行了");
    _tabController = TabController(length: _tags.length, vsync: this);
  }

  Future<String?> fetchData() async {
    var res = await DioUtil().getUserIntialInfo();
    setState(() {
      _data = res;
      _isLoading = false;
      // _tags = _data['data']['loginInformationId']['labels'];
      // print(_data['data']['loginInformationId']['labels']);
    });
    return "success";
  }

  int _currentIndex = 0;
  late List<Post> posts;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

//! 造数据，这里展示20条数据
  List<Post> generatePosts() {
    List<Post> fake = [];
    for (int i = 0; i < 20; i++) {
      fake.add(Post(
        title: geneTitle(),
        content: geneContent(),
        author: getAuthor(),
        date: getDate(),
        tag: "${_tags[Random().nextInt(_tags.length)]}",
        image: Random().nextInt(10).toString(),
        //! 后面索引是10张图片，这里就用索引
        thume_up_num: Random().nextInt(1000).toString(),
        comments: geneComments(),
        //! 生成10条评论
        id: "$i",
      ));
    }
    return fake;
  }

  //! 生成tabView视图，这里除了首页调用的参数都是随机生成的
  List<Widget> generateTabViews() {
    List<Widget> tabViews = [];
    for (int i = 0; i < _tags.length; i++) {
      if (i == 0) {
        tabViews.add(CustomScrollView(
          slivers: [
            SlideShow(),
            PostList(posts: generatePosts()),
          ],
        ));
        continue;
      }
      if (i >= _tags.length - 2) {
        tabViews.add(CustomScrollView(
          slivers: [
            essayListPage(posts: generatePost_essay(10)),
          ],
        ));
        continue;
      }
      tabViews.add(CustomScrollView(
        slivers: [
          PostList(posts: generatePosts()),
        ],
      ));
    }
    return tabViews;
  }

  @override
  Widget build(BuildContext context) {
    // 打印检查主页
    // print(widget.check);

    return _isLoading
        ? Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          )
        : Scaffold(
            // !原先单页的代码
            // body: CustomScrollView(
            //
            //   slivers: [
            //     Head(tabController: _tabController, tags: _tags),
            //     SlideShow(),
            //     PostList(posts: this.posts),
            //   ],
            // ),
            //! 这里显示的滚动条下的页面，这里可以用head了
            body: CustomScrollView(slivers: [
              Head(
                  tabController: _tabController,
                  tags: _tags,
                  isUser: widget.check),
              SliverFillRemaining(
                child: TabBarView(
                  controller: _tabController,
                  children: generateTabViews(),
                ),
              )
            ]),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // 按钮被按下时执行的操作
                print(_tabController.index);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WritePage()),
                );
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.blue,
            ),
          );
  }
}

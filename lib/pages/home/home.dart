import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_blog/pages/home/action.dart';
import 'package:my_blog/pages/home/head.dart';
import 'package:my_blog/pages/home/postList.dart';
import 'package:my_blog/pages/home/slideShow.dart';
import 'package:my_blog/services/homeAPI.dart';
import 'dart:math';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  int _currentIndex = 0;
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
  late List<Post> posts;

  @override
  void initState() {
    super.initState();
    posts = generatePosts();    //初始化生成数据
    print(posts);
    print("我被执行了");

    _tabController = TabController(length: _tags.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

//! 造数据，这里展示20条数据
  List<Post> generatePosts() {
    List<Post> fake = [];
    for (int i = 0; i < 10; i++) {
      fake.add(Post(
        title: "title$i",
        content: "content$i",
        author: "author$i",
        date: "date$i",
        tag: "tag$i",
        image: Random().nextInt(10).toString(),                //! 后面索引是10张图片，这里就用索引
        thume_up_num: Random().nextInt(1000).toString(),
        id: "$i",
      ));
    }
    return fake;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          Head(tabController: _tabController, tags: _tags),
          SlideShow(),
          PostList(posts: this.posts),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print(HomeAPI.getBaseData("SS"));
          final data = await HomeAPI.getBaseData("");
          print(data['data']['records'][5]['content']);
          setState(() {
            // posts = generatePosts();
            // posts = data['data']['records'];
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

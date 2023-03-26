import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_blog/pages/home/action.dart';
import 'package:my_blog/pages/home/head.dart';
import 'package:my_blog/pages/home/postList.dart';
import 'package:my_blog/pages/home/slideShow.dart';
import 'package:my_blog/services/homeAPI.dart';

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
  String mk = "home";

  @override
  void initState() {
    super.initState();
    print("我被执行了");

    _tabController = TabController(length: _tags.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
          slivers: [
          Head(tabController: _tabController, tags: _tags),
      SlideShow(),
      PostList(posts: [
        Post(
          title: "Flutter 2.0 发布，全新的 Dart 语言特性",
          content: mk,
          author: 's',
          date: 's',
          tag: 's',
          image: 's',)
          ],),
      ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print(HomeAPI.getBaseData("SS"));
          final data = await HomeAPI.getBaseData("SS");
          print(data['data']['records'][5]['content']);
          setState(() {
            mk = data['data']['records'][5]['content'];
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

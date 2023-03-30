import 'package:flutter/material.dart';
import 'package:my_blog/pages/home/action.dart';
import 'package:my_blog/pages/person/person.dart';
import 'package:my_blog/pages/person/personlist.dart';

class Head extends StatelessWidget {
  final tabController;

  final List<String> tags;

  const Head({Key? key, required this.tabController, required this.tags})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      centerTitle: false,
      snap: true,
      backgroundColor: Colors.white,

      leading: GestureDetector(
        onTap: () {
          var route = PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 200),
            pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) =>
                personList(),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return SlideTransition(
                position:
                    Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset.zero)
                        .animate(animation),
                child: child,
              );
            },
          );
          Navigator.push(context, route);
        },
        child: Container(
          margin: EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/avatar.jpg'),
            radius: 5,
          ),
        ),
      ),
      title: Container(
        height: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.grey[200],
        ),
        //margin: EdgeInsets.symmetric(horizontal: 15.0),
        padding: EdgeInsets.only(left: 15, right: 0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: '搜索',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(bottom: 10.0),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.search, color: Colors.black),
              onPressed: () {
                // TODO: 处理搜索逻辑
              },
            ),
          ],
        ),
      ),
      actions: [MyAction()],
      // flexibleSpace: Container(
      //   height: 100,
      //   decoration: BoxDecoration(
      //     image: DecorationImage(
      //       image: AssetImage('assets/images/avatar.jpg'),
      //       fit: BoxFit.cover,
      //     ),
      //   ),
      // ),
      bottom: TabBar(
        onTap: (index) {
          print(index);
        },
        labelStyle: TextStyle(fontSize: 16.0),
        unselectedLabelStyle: TextStyle(fontSize: 11.0),
        //指示器大小
        indicatorSize: TabBarIndicatorSize.tab,
        //标签左右的内边距
        labelPadding: EdgeInsets.only(left: 8.0, right: 8.0),
        //控制器
        controller: tabController,
        //是否可滚动
        isScrollable: true,
        //指示器颜色
        indicatorColor: Colors.blue,
        //选中标签的文本颜色
        labelColor: Colors.blue,
        //未选中标签的文本颜色
        unselectedLabelColor: Colors.grey,
        //标签
        tabs: [
          //将tags中的每个元素转换成一个Tab，并将它们组成列表
          // ...tags.map((tag) => Tab(text: tag)).toList(),

          Tab(text: 'home'),
          Tab(text: 'spring boot'),
          Tab(text: 'spring cloud'),
          Tab(text: 'react'),
          Tab(text: 'umi.js'),
          Tab(text: 'H5'),
          Tab(text: 'flutter'),
          Tab(text: 'CSS3'),
          Tab(text: 'Spaces'),
          Tab(text: 'Entertainment'),
        ],
      ),
    );
  }
}

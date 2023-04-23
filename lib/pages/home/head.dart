import 'package:flutter/material.dart';
import 'package:my_blog/pages/home/action.dart';
import 'package:my_blog/pages/person/person.dart';
import 'package:my_blog/pages/person/personlist.dart';

class Head extends StatelessWidget {
  bool isUser = true;
  final tabController;
  final List<String> tags;

  Head(
      {Key? key,
      required this.tabController,
      required this.tags,
      required this.isUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 打印检查主页
    // print(isUser);

    return SliverAppBar(
      floating: true,
      centerTitle: false,
      snap: true,
      backgroundColor: Colors.white,

      leading: this.isUser
          ? GestureDetector(
              onTap: () {
                var route = PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 200),
                  pageBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation) =>
                      personList(),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    return SlideTransition(
                      position: Tween<Offset>(
                              begin: Offset(-1.0, 0.0), end: Offset.zero)
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
            )
          : IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
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

      actions: isUser ? [MyAction()] : null,
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
          if (index == 8 || index == 9) {
            print('y');
          }
        },
        labelStyle: TextStyle(fontSize: 20.0),
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
        tabs: tags.map((tag) {
          if (tag == 'home') {
            return Tab(
              text: tag,
              icon: Icon(Icons.home, color: Colors.lightBlue),
            );
          } else if (tag == 'space') {
            return Tab(
              text: tag,
              icon: Icon(Icons.catching_pokemon, color: Colors.cyan),
            );
          } else if (tag == 'entertainment') {
            return Tab(
              text: tag,
              icon: Icon(Icons.beach_access_outlined, color: Colors.cyan),
            );
          } else {
            return Tab(
              icon: Icon(Icons.web),
              text: tag,
            );
          }
        }).toList(),
        // tabs: [
        //   //将tags中的每个元素转换成一个Tab，并将它们组成列表
        //   // ...tags.map((tag) => Tab(text: tag)).toList(),
        //
        //   Tab(
        //     icon: Icon(Icons.home),
        //     text: 'home',
        //   ),
        //   Tab(
        //     icon: Icon(Icons.wifi),
        //     text: 'spring boot',
        //   ),
        //   Tab(
        //     icon: Icon(Icons.cloud),
        //     text: 'spring cloud',
        //   ),
        //   Tab(
        //     icon: Icon(Icons.web),
        //     text: 'react',
        //   ),
        //   Tab(
        //     icon: Icon(Icons.web_asset),
        //     text: 'umi.js',
        //   ),
        //   Tab(
        //     icon: Icon(Icons.phone_iphone),
        //     text: 'H5',
        //   ),
        //   Tab(
        //     icon: Icon(Icons.flutter_dash),
        //     text: 'flutter',
        //   ),
        //   Tab(
        //     icon: Icon(Icons.style),
        //     text: 'CSS3',
        //   ),
        //
        //   Tab(
        //     icon: Icon(
        //       Icons.catching_pokemon,
        //       color: Colors.cyan,
        //     ),
        //     text: 'Spaces',
        //   ),
        //   Tab(
        //     icon: Icon(
        //       Icons.beach_access_outlined,
        //       color: Colors.cyan,
        //     ),
        //     text: 'Entertainment',
        //   ),
        // ],
      ),
    );
  }
}

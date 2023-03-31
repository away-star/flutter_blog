import 'package:flutter/material.dart';
import 'package:my_blog/pages/person/login_page.dart';
import 'package:my_blog/pages/person/person.dart';

class personList extends StatelessWidget {
  // final String text;

  personList({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      body: SizedBox(
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.05,),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                color: Colors.white,
                icon: Icon(Icons.chevron_right, size: 30, color: Colors.black,),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),

            CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar.jpg'),
              //这里设置的是半径
              radius: 40,
            ),
            SizedBox(height: 10,),
            Text('xingxing',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Divider(
              color: Colors.grey[300],
              thickness: 1,
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () {
                  // 点击事件处理
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return Person(
                          name: "xingxing",
                          email: "2064989403@qq.com",
                          signature:
                          "So far all life is written with failure, but this does not prevent me from moving forward",
                          location: "China",
                        );
                      }));
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 12.0), // 内间距
                  // backgroundColor: Colors.white, // 背景色
                ),
                icon: Icon(
                  Icons.person_pin_outlined, color: Colors.grey, size: 30,),
                // 图标
                label: Text(
                  'Personal Information',
                  style: TextStyle(
                    color: Colors.grey, // 文字颜色
                    fontSize: 20.0, // 文字大小
                    fontWeight: FontWeight.bold, // 加粗
                  ),
                ),
              ),
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () {
                  // 点击事件处理
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 12.0), // 内间距
                  // backgroundColor: Colors.white, // 背景色
                ),
                icon: Icon(
                  Icons.notification_add, color: Colors.grey, size: 30,), // 图标
                label: Text(
                  'Notification',
                  style: TextStyle(
                    color: Colors.grey, // 文字颜色
                    fontSize: 20.0, // 文字大小
                    fontWeight: FontWeight.bold, // 加粗
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () {
                  // 点击事件处理
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 12.0), // 内间距
                  // backgroundColor: Colors.white, // 背景色
                ),
                icon: Icon(
                  Icons.stacked_bar_chart, color: Colors.grey, size: 30,), // 图标
                label: Text(
                  'Your content and stats',
                  style: TextStyle(
                    color: Colors.grey, // 文字颜色
                    fontSize: 20.0, // 文字大小
                    fontWeight: FontWeight.bold, // 加粗
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () {
                  // 点击事件处理
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 12.0), // 内间距
                  // backgroundColor: Colors.white, // 背景色
                ),
                icon: Icon(
                  Icons.pending_actions, color: Colors.grey, size: 30,), // 图标
                label: Text(
                  'Drafts',
                  style: TextStyle(
                    color: Colors.grey, // 文字颜色
                    fontSize: 20.0, // 文字大小
                    fontWeight: FontWeight.bold, // 加粗
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () {
                  // 点击事件处理
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 12.0), // 内间距
                  // backgroundColor: Colors.white, // 背景色
                ),
                icon: Icon(
                  Icons.bookmark_add_outlined, color: Colors.grey, size: 30,),
                // 图标
                label: Text(
                  'Bookmarks',
                  style: TextStyle(
                    color: Colors.grey, // 文字颜色
                    fontSize: 20.0, // 文字大小
                    fontWeight: FontWeight.bold, // 加粗
                  ),
                ),
              ),
            ),
            Divider(
              color: Colors.grey[300],
              thickness: 1,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () {
                  // 点击事件处理
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 12.0), // 内间距
                  // backgroundColor: Colors.white, // 背景色
                ),
                icon: Icon(Icons.login, color: Colors.grey, size: 30,), // 图标
                label: Text(
                  'Log In',
                  style: TextStyle(
                    color: Colors.grey, // 文字颜色
                    fontSize: 20.0, // 文字大小
                    fontWeight: FontWeight.bold, // 加粗
                  ),
                ),
              ),
            ),


            Expanded(child: SizedBox(),),
            Divider(
              color: Colors.grey[300],
              thickness: 1,
            ),
            Row(
              children: [
                TextButton.icon(
                  onPressed: () {
                    // 点击事件处理
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 10.0), // 内间距
                    // backgroundColor: Colors.white, // 背景色
                  ),
                  icon: Icon(Icons.settings, color: Colors.grey, size: 25,),
                  // 图标
                  label: Text(
                    'Settings',
                    style: TextStyle(
                      color: Colors.grey, // 文字颜色
                      fontSize: 15.0, // 文字大小
                      fontWeight: FontWeight.bold, // 加粗
                    ),
                  ),
                ),
                Expanded(child: SizedBox()),
                PopupMenuButton(
                  itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry>[
                    PopupMenuItem(child: Text('选项一')),
                    PopupMenuItem(child: Text('选项二')),
                    PopupMenuItem(child: Text('选项三')),
                  ],
                  child: IconButton(
                    padding: EdgeInsets.fromLTRB(0, 0, 35, 0),
                    icon: Icon(
                      Icons.more_horiz_sharp, color: Colors.grey, size: 35,),
                    onPressed: () {
                      // Do something when button pressed
                    },
                  ),
                )

              ],
            ),
            SizedBox(height: 15,),


          ],
        ),
      ),
    );
    // return Column(
    //   children: [
    //     CircleAvatar(
    //       backgroundImage: AssetImage('assets/images/avatar.jpg'),
    //       //这里设置的是半径
    //       radius: 40,
    //     ),
    //
    //   ],
    // );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:markdown_widget/config/all.dart';
import 'package:my_blog/common/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:my_blog/pages/detail/MyMD.dart';

class Person extends StatefulWidget {
  final tocContorllr = TocController();
  final String name;
  final String email;

  // final String avatar; // 头像？
  final String signature;
  final String location;

  Person({
    Key? key,
    required this.name,
    required this.email,
    required this.signature,
    required this.location,
  }) : super(key: key);

  @override
  State<Person> createState() => _PersonState();
}

class _PersonState extends State<Person> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              //让头像可以超出图片范围
              clipBehavior: Clip.none,
              children: [
                Image.network(
                  'https://picsum.photos/id/1025/600/300',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
                Positioned(
                  right: 10,
                  top: 30,
                  child: IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.keyboard_double_arrow_right, size: 30),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                //用户头像
                Positioned(
                  left: 5,
                  bottom: -40,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/avatar.jpg'),
                    //这里设置的是半径
                    radius: 40,
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: IconButton(
                    icon: Icon(Icons.qr_code_2_sharp, color: Colors.white),
                    onPressed: () {
                      // add share functionality here
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                  ),
                )
              ],
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 80),
                    child: Text(
                      '${widget.name}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(Icons.email_outlined,
                          color: Colors.grey[700], size: 25),
                      SizedBox(width: 10),
                      Text(
                        '${widget.email}',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(
                    color: Colors.grey[300],
                    thickness: 1,
                  ),
                  Row(
                    //让它自动换行
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.bookmark_border,
                          color: Colors.grey[700], size: 27),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          '${widget.signature}',
                          style: TextStyle(
                            fontFamily: 'cursive',
                            // fontStyle: FontStyle.italic,
                            color: Colors.grey[500],
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.grey[300],
                    thickness: 1,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.location_on,
                          color: Colors.grey[700], size: 25),
                      SizedBox(width: 10),
                      Text(
                        '${widget.location}',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '(未授权定位)',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      // Icon(Icons.code_sharp, color: Colors.grey[700], size: 20),
                      FaIcon(FontAwesomeIcons.github,
                          color: Colors.grey[700], size: 25),
                      SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            //打开网页
                            //launch(githubAddr);
                            launchUrlString(githubAddr);
                          },
                          child: Text(
                            githubAddr,
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.grey[300],
                    thickness: 2,
                  ),

                  MarkdownPage(data: """
# 建站说明
对于移动应用开发来说，你可以使用
```python
def quick_sort(arr):
    if len(arr) <= 1:
        return arr
    pivot = arr[len(arr) // 2]
    left = [x for x in arr if x < pivot]
    middle = [x for x in arr if x == pivot]
    right = [x for x in arr if x > pivot]
    return quick_sort(left) + middle + quick_sort(right)
```
来建立一个**web前端**对于移动应用开发来说，你可以使用
```python
def quick_sort(arr):
    if len(arr) <= 1:
        return arr
    pivot = arr[len(arr) // 2]
    left = [x for x in arr if x < pivot]
    middle = [x for x in arr if x == pivot]
    right = [x for x in arr if x > pivot]
    return quick_sort(left) + middle + quick_sort(right)
```
来建立一个**web前端**来建立一个**web前端**对于移动应用开发来说，你可以使用
```python
def quick_sort(arr):
    if len(arr) <= 1:
        return arr
    pivot = arr[len(arr) // 2]
    left = [x for x in arr if x < pivot]
    middle = [x for x in arr if x == pivot]
    right = [x for x in arr if x > pivot]
    return quick_sort(left) + middle + quick_sort(right)
```
来建立一个**web前端**
                  """, tocController: widget.tocContorllr),

                  //! 结尾
                  AnimatedContainer(
                    duration: Duration(milliseconds: 2000),
                    curve: Curves.easeInOut,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF5B86E5),
                          Color(0xFF36D1DC),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Text(
                      'Power by Flutter',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontFamily: "cursive",
                        color: Colors.white,
                        fontSize: 56.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

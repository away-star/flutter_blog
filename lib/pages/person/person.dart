import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:markdown_widget/config/all.dart';
import 'package:my_blog/common/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:my_blog/pages/detail/MyMD.dart';
import 'package:my_blog/pages/person/person_edit.dart';
import 'package:my_blog/utils/APIUtil.dart';

class Person extends StatefulWidget {
  final tocContorllr = TocController();
  late String name;
  late String email;

  // final String avatar; // 头像？
  late String signature;
  late String location;

  Person();

  @override
  State<Person> createState() => _PersonState();
}

class _PersonState extends State<Person> {
  bool _isLoading = true;
  Map<String, dynamic> _data = {};

  @override
  initState() {
    super.initState();
    // fetchData();
    fetchData();
  }

  Future<String?> fetchData() async {
    var data = await DioUtil().getUserIntialInfo();
    setState(() {
      _data = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          )
        : Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    //让头像可以超出图片范围
                    clipBehavior: Clip.none,
                    children: [
                      Image.network(
                        // 'https://picsum.photos/id/1025/600/300',
                        "https://www.itying.com/images/flutter/1.png",
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 200,
                      ),
                      Positioned(
                        right: 10,
                        top: 30,
                        child: IconButton(
                          color: Colors.white,
                          icon: Icon(Icons.close, size: 30),
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
                          backgroundImage:
                          AssetImage('assets/images/avatar.jpg'),
                          // AssetImage('${_data['data']['userInfoDto']['avatar']}'),
                          //这里设置的是半径
                          radius: 40,
                        ),
                      ),
                      Positioned(
                        right: 10,
                        bottom: 10,
                        child: IconButton(
                          icon:
                              Icon(Icons.qr_code_2_sharp, color: Colors.white),
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
                            '${_data['data']['userInfoDto']['nickname']}',
                            // "名字",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        //! 增加一个修改个人资料的按钮
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Container(
                              height: 1,
                              color: Colors.grey[300],
                            )),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PersonEditPage()));
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                side: BorderSide(color: Colors.blue, width: 1),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.edit, size: 16),
                                  SizedBox(width: 4),
                                  Text(
                                    '编辑个人资料',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20),
                        // 邮箱地址
                        Row(
                          children: [
                            Icon(Icons.email_outlined,
                                color: Colors.grey[700], size: 25),
                            SizedBox(width: 10),
                            Text(
                              '${_data['data']['userInfoDto']['email']}',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.grey[300],
                          thickness: 1,
                        ),

                        // 性别
                        Row(
                          //让它自动换行
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.person,
                                color: Colors.grey[700], size: 23),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                '${_data['data']['userInfoDto']['gender']}',
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.grey[300],
                          thickness: 1,
                        ),

                        // 生日
                        Row(
                          //让它自动换行
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.calendar_today,
                                color: Colors.grey[700], size: 23),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                '${_data['data']['userInfoDto']['birthday']}',
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.grey[300],
                          thickness: 1,
                        ),

                        // 个性签名
                        Row(
                          //让它自动换行
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.bookmark_border,
                                color: Colors.grey[700], size: 29),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                '${_data['data']['userInfoDto']['idiograph']}',
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
                              '${_data['data']['userInfoDto']['adress']}',
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
                                  launchUrlString(Constants.githubAddr);
                                },
                                child: Text(
                                  Constants.githubAddr,
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

                        MarkdownPage(
                            data:
                                "${_data['data']['userInfoDto']['welcomeText']}",
                            tocController: widget.tocContorllr),

                        //! 结尾
                        AnimatedContainer(
                          duration: Duration(milliseconds: 2000),
                          curve: Curves.easeInOut,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0),
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

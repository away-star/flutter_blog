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
                            launchUrlString( Constants.githubAddr);
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

                  MarkdownPage(data: """
## 项目名称

### 简介

此项目为 **xxx** 的**前端**部分，用于实现**手机界面**。本文档为该项目的开发文档。

### 项目实现

#### 技术选型

- 应用框架：Flutter

    - Flutter 是一个快速开发高质量、高性能的移动应用框架。Flutter 使用现代化的语言 Dart 开发，其极速的开发和热重载功能使得团队可以高效协作和迭代，同时，Flutter 支持多平台开发，使得我们可以快速开发出高质量的 iOS 和 Android 应用。

- 开发环境：

    - 开发工具：Android Studio，VScode
    - 版本控制工具：Git

- 组件库

    - Cupertino Icons：提供 iOS 风格图标字体库
    - material_design_icons_flutter：提供 Material Design 图标字体库

- 第三方库

    - carousel_slider：实现图片轮播组件
    - cached_network_image：提供网络图片加载工具，可缓存图片
    - flutter_svg：提供 SVG 图片渲染工具
    - markdown_widget：提供 Markdown 渲染 widget
    - flutter_markdown：提供 Markdown 渲染库
    - flutter_highlight：提供代码高亮库
    - url_launcher：提供启动 URL 资源的工具
    - font_awesome_flutter：提供字体图标库，包含超过 5,000 种图标

#### 架构设计

- 数据层：负责管理应用程序的数据。包括与服务器的网络通信，本地数据的缓存等。在 Flutter 中，我们可以使用 Dart 具有的异步特性来进行网络请求，并使用 SQLite 或 SharedPreferences 等本地存储库来缓存数据。


- 业务逻辑层：负责管理应用程序的业务逻辑，例如按时间顺序显示会话记录、接收消息并显示通知等处理。

- 视图层：通常是在屏幕上绘制用户界面元素。在博客应用中，我们可以通过使用 Flutter 提供的 Material Design 组件库，实现简单的 UI 布局。包括聊天气泡、头像、键盘等界面元素。

- 交互层：与用户交互的各种操作。例如：点击、滑动手势等交互操作。在 Flutter 中，我们可以通过 GestureDetector 组件来使用这些操作。

### 项目结构

```bash
flutter_blog
│  ├─ app
│  │  ├─ build.gradle
│  │  └─ src
│  │     ├─ debug
│  │     │  └─ AndroidManifest.xml
│  │     ├─ main
│  │     │  ├─ AndroidManifest.xml
│  │     │  ├─ java
│  │     │  │  ├─ com
│  │     │  │  │  └─ star
│  │     │  │  │     └─ my_blog
│  │     │  │  │        └─ MainActivity.java
│  │     │  │  └─ io
│  │     │  │     └─ flutter
│  │     │  │        └─ plugins
│  │     │  │           └─ GeneratedPluginRegistrant.java
│  │     │  └─ res
│  │     │     ├─ drawable
│  │     │     │  └─ launch_background.xml
│  │     │     ├─ drawable-v21
│  │     │     │  └─ launch_background.xml
│  │     │     ├─ mipmap-hdpi
│  │     │     │  └─ ic_launcher.png
│  │     │     ├─ mipmap-mdpi
│  │     │     │  └─ ic_launcher.png
│  │     │     ├─ mipmap-xhdpi
│  │     │     │  └─ ic_launcher.png
│  │     │     ├─ mipmap-xxhdpi
│  │     │     │  └─ ic_launcher.png
│  │     │     ├─ mipmap-xxxhdpi
│  │     │     │  └─ ic_launcher.png
│  │     │     ├─ values
│  │     │     │  └─ styles.xml
│  │     │     └─ values-night
│  │     │        └─ styles.xml
│  │     └─ profile
│  │        └─ AndroidManifest.xml
│  ├─ build.gradle
│  ├─ gradle
│  │  └─ wrapper
│  │     ├─ gradle-wrapper.jar
│  │     └─ gradle-wrapper.properties
│  ├─ gradle.properties
│  ├─ gradlew
│  ├─ gradlew.bat
│  ├─ local.properties
│  └─ settings.gradle
├─ assets                   
│  └─ images
│     ├─ 63786236598065.png
│     └─ avatar.jpg
├─ ios
│  ├─ .gitignore
│  ├─ Flutter
│  │  ├─ AppFrameworkInfo.plist
│  │  ├─ Debug.xcconfig
│  │  ├─ flutter_export_environment.sh
│  │  ├─ Generated.xcconfig
│  │  └─ Release.xcconfig
├─ lib
│  ├─ common
│  │  └─ constants.dart
│  ├─ main.dart
│  ├─ pages
│  │  ├─ detail
│  │  │  ├─ bottomInfo.dart
│  │  │  ├─ detail.dart
│  │  │  ├─ mdToc.dart
│  │  │  ├─ myCatalog.dart
│  │  │  └─ MyMD.dart
│  │  ├─ home
│  │  │  ├─ action.dart
│  │  │  ├─ data.dart
│  │  │  ├─ essay.dart
│  │  │  ├─ fun.dart
│  │  │  ├─ funList.dart
│  │  │  ├─ head.dart
│  │  │  ├─ home.dart
│  │  │  ├─ postList.dart
│  │  │  └─ slideShow.dart
│  │  └─ person
│  │     ├─ login_page.dart
│  │     ├─ person.dart
│  │     └─ personlist.dart
│  └─ services
│     └─ homeAPI.dart
├─ linux
│  ├─ .gitignore
│  ├─ CMakeLists.txt
│  ├─ flutter
│  │  ├─ CMakeLists.txt
│  │  ├─ generated_plugins.cmake
│  │  ├─ generated_plugin_registrant.cc
│  │  └─ generated_plugin_registrant.h
│  ├─ main.cc
│  ├─ my_application.cc
│  └─ my_application.h
├─ macos
│  ├─ .gitignore
│  ├─ Flutter
│  │  ├─ ephemeral
│  │  │  ├─ Flutter-Generated.xcconfig
│  │  │  └─ flutter_export_environment.sh
│  │  ├─ Flutter-Debug.xcconfig
│  │  ├─ Flutter-Release.xcconfig
│  │  └─ GeneratedPluginRegistrant.swift
│  ├─ Runner
│  │  ├─ AppDelegate.swift
│  │  ├─ Assets.xcassets
│  │  │  └─ AppIcon.appiconset
│  │  │     ├─ app_icon_1024.png
│  │  │     ├─ app_icon_128.png
│  │  │     ├─ app_icon_16.png
│  │  │     ├─ app_icon_256.png
│  │  │     ├─ app_icon_32.png
│  │  │     ├─ app_icon_512.png
│  │  │     ├─ app_icon_64.png
│  │  │     └─ Contents.json
│  │  ├─ Base.lproj
│  │  │  └─ MainMenu.xib
│  │  ├─ Configs
│  │  │  ├─ AppInfo.xcconfig
│  │  │  ├─ Debug.xcconfig
│  │  │  ├─ Release.xcconfig
│  │  │  └─ Warnings.xcconfig
│  │  ├─ DebugProfile.entitlements
│  │  ├─ Info.plist
│  │  ├─ MainFlutterWindow.swift
│  │  └─ Release.entitlements
│  ├─ Runner.xcodeproj
│  │  ├─ project.pbxproj
│  │  ├─ project.xcworkspace
│  │  │  └─ xcshareddata
│  │  │     └─ IDEWorkspaceChecks.plist
│  │  └─ xcshareddata
│  │     └─ xcschemes
│  │        └─ Runner.xcscheme
│  └─ Runner.xcworkspace
│     ├─ contents.xcworkspacedata
│     └─ xcshareddata
│        └─ IDEWorkspaceChecks.plist
├─ pubspec.lock
├─ pubspec.yaml
├─ README.md
├─ test
│  └─ widget_test.dart
├─ web
│  ├─ favicon.png
│  ├─ icons
│  │  ├─ Icon-192.png
│  │  ├─ Icon-512.png
│  │  ├─ Icon-maskable-192.png
│  │  └─ Icon-maskable-512.png
│  ├─ index.html
│  └─ manifest.json
└─ windows
   ├─ .gitignore
   ├─ CMakeLists.txt
   ├─ flutter
   │  ├─ CMakeLists.txt
   │  ├─ ephemeral
   │  │  └─ .plugin_symlinks
   │  ├─ generated_plugins.cmake
   │  ├─ generated_plugin_registrant.cc
   │  └─ generated_plugin_registrant.h
   └─ runner
      ├─ CMakeLists.txt
      ├─ flutter_window.cpp
      ├─ flutter_window.h
      ├─ main.cpp
      ├─ resource.h
      ├─ resources
      │  └─ app_icon.ico
      ├─ runner.exe.manifest
      ├─ Runner.rc
      ├─ utils.cpp
      ├─ utils.h
      ├─ win32_window.cpp
      └─ win32_window.h
```

### 项目启动

请确保已安装Flutter SDK。

在终端中输入以下命令：
安装所需包
```bash
pub get
```

运行
```bash
flutter run
```

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

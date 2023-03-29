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
    posts = generatePosts(); //初始化生成数据
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
    for (int i = 0; i < 20; i++) {
      fake.add(Post(
        title: "${generateRandomStrings(1, 15)[0]}",
        content: """
你可以使用内联代码格式来强调你所写的一行中的一个小命令或一段语法。
例如，你可能希望提到 JavaScript 的 Array.protoype.map() 方法。通过使用内联代码格式化，可以清楚地看到这是一段代码。你也可以用它来说明一个终端命令，比如 yarn install。
要使用内联代码格式化，只需将你希望格式化的代码用反斜线包起来。在一个标准的 QWERTY 键盘上，可以在 “1” 的左边和 Tab 键的上面找到它。关于键盘上反引号的位置的更多信息，本文下方有介绍。
例如，在 markdown 中写 `Array.prototype.map()` 会呈现为 Array.prototype.map()。
代码块
要写更长或更详细的代码片段，通常最好把它们放在一个代码块内。代码块允许你使用多行，而 markdown 会在它的后台用代码类型的字体渲染。

为了达到这个目的，在你的代码块开始的时候，要有一行三个反引号。这向 markdown 表明你正在创建一个代码块。你将需要用另一行三个反引号来结束，比如：

```
var add2 = function(number) {
 return number + 2;
}
```

将被 markdown 渲染为：
语法高亮不仅可以应用于 JavaScript。你可以使用
```html：
<div class="row">
  <div class="col-md-6 col-md-offset-3">
    <h1>Hello World</h1>
  </div>
</div>
```

```ruby
"Hello World".split('').each do |letter|
  puts letter
end
```

```python：

a, b = 0, 1
while b < 10:
    print(b)
    a, b = a, a + b
```
请记住，不是所有的 markdown 引擎都会应用语法高亮。

国际键盘上的反引号
在不同的键盘上，反引号的位置可能不同，如果你使用的不是 QWERTY 键盘，可能会很难找到它。这份有用的指南列出了一些寻找回车键的方法，我们将其收集在下面：""",
        author: "author$i",
        date: "date$i",
        tag: "${_tags[Random().nextInt(_tags.length)]}",
        image: Random().nextInt(10).toString(),
        //! 后面索引是10张图片，这里就用索引
        thume_up_num: Random().nextInt(1000).toString(),
        comments: generateRandomStrings(Random().nextInt(30), 200),
        //! 生成10条评论
        id: "$i",
      ));
    }
    return fake;
  }

  List<String> generateRandomStrings(int count, int length) {
    List<String> strings = [];
    Random random = Random();

    for (int i = 0; i < count; i++) {
      String randomString = '';

      for (int j = 0; j < length; j++) {
        int randomInt = random.nextInt(26);
        randomString += String.fromCharCode(randomInt + 97);
      }

      strings.add(randomString);
    }

    return strings;
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
    return Scaffold(
      // !原先单页的代码
      // body: CustomScrollView(
      //
      //   slivers: [
      //     Head(tabController: _tabController, tags: _tags),
      //     SlideShow(),
      //     PostList(posts: this.posts),
      //   ],
      // ),
      body: CustomScrollView(
        slivers: [
          Head(tabController: _tabController, tags: _tags),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: generateTabViews(),
            ),
          )
        ]
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

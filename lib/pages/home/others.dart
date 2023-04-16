// import 'package:flutter/material.dart';
// import 'package:my_blog/pages/home/funList.dart';
//
// import '../checkIn/custom_route.dart';
// import 'home.dart';
//
// class SpacePage extends StatelessWidget {
//   List<String> nameList = ["淡出显示图片", "直接显示图片的组件"];
//
//   SpacePage({required this.nameList});
//
//   @override
//   Widget build(BuildContext context) {
//     int itemsLength = this.nameList.length;
//     final List<String> items =
//         List<String>.generate(itemsLength, (i) => "Item $i");
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: CustomScrollView(
//         slivers: <Widget>[
//           SliverAppBar(
//             expandedHeight: 200.0,
//             flexibleSpace: FlexibleSpaceBar(
//               title: Text('Welcome to Space'),
//               background: Image.network(
//                 "https://www.itying.com/images/flutter/4.png",
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           SliverList(
//             delegate: SliverChildBuilderDelegate(
//               (BuildContext context, int index) {
//                 return Padding(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
//                   child: Card(
//                     child: ListTile(
//                         leading: CircleAvatar(
//                           backgroundColor: Colors.grey[300],
//                           backgroundImage: NetworkImage(
//                               "https://www.itying.com/images/flutter/1.png"),
//                         ),
//                         title: Text(
//                             '${index < nameList.length ? nameList[index] : "未完成"}'),
//                         // subtitle: Text(items[index]),
//                         subtitle: Text(
//                           '成功的秘诀就是每天都比昨天更努力',
//                           style: TextStyle(
//                             // fontFamily: '',
//                             color: Colors.grey[500],
//                             fontSize: 14.0,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                         trailing: Icon(Icons.keyboard_arrow_right),
//                         onTap: () {
//                           Navigator.of(context).pushReplacement(
//                             FadePageRoute(
//                               builder: (context) => Home(check: false,),
//                             ),
//                           );
//                         }),
//                   ),
//                 );
//               },
//               childCount: items.length,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../checkIn/custom_route.dart';
import 'home.dart';

class SpacePage extends StatelessWidget {
  final List<String> images = [
    'https://picsum.photos/id/101/400/600',
    'https://picsum.photos/id/102/400/600',
    'https://picsum.photos/id/276/800/1200',
    'https://picsum.photos/id/291/800/568',
    'https://picsum.photos/id/292/800/1067',
    'https://picsum.photos/id/305/800/500',
    'https://picsum.photos/id/309/800/1200',
    'https://picsum.photos/id/310/800/1200',
    'https://picsum.photos/id/313/800/800',
    'https://picsum.photos/id/315/800/533',
    'https://picsum.photos/id/324/800/534',
    'https://picsum.photos/id/109/400/600',
    'https://picsum.photos/id/110/400/600',
    'https://picsum.photos/id/111/400/600',
    'https://picsum.photos/id/112/400/600',
    'https://picsum.photos/id/113/400/600',
    'https://picsum.photos/id/114/400/600',
    'https://picsum.photos/id/115/400/600',
    'https://picsum.photos/id/116/400/600',
    'https://picsum.photos/id/117/400/600',
    'https://picsum.photos/id/118/400/600',
    'https://picsum.photos/id/119/400/600',
    'https://picsum.photos/id/120/400/600',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('瀑布流页面'),
        flexibleSpace: FlexibleSpaceBar(
          title: Text('Welcome to Space'),
          background: Image.network(
            "https://www.itying.com/images/flutter/4.png",
            fit: BoxFit.cover,
          ),
        ),
      ),
      body: StaggeredGridView.countBuilder(
        crossAxisCount: 2,
        itemCount: images.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              print("跳转");
              Navigator.of(context).pushReplacement(
                FadePageRoute(
                  builder: (context) => Home(
                    check: false,
                  ),
                ),
              );
            },
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      images[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                'assets/images/avatar.jpg',
                                width: 30.0,
                                height: 30.0,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              '昵称',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.verified,
                              color: Colors.blue,
                              size: 16,
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          '成功的秘诀就是每天都比昨天更努力',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
        staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        padding: EdgeInsets.all(8),
      ),
    );
  }
}

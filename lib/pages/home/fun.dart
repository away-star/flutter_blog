import 'package:flutter/material.dart';
import 'package:my_blog/pages/home/funList.dart';

class FunWidgetsPage extends StatelessWidget {
  final List<String> items = List<String>.generate(100, (i) => "Item $i");

  List<Widget> _buildList = [AnimatedImage(), ImageDetail()];
  List<String> nameList = ["淡出显示图片", "直接显示图片的组件"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Fun Widgets'),
              background: Image.network(
                "https://www.itying.com/images/flutter/4.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        child: Text('${index + 1}'),
                      ),
                      title: Text('${index < nameList.length ? nameList[index] : "未完成"}'),
                      // subtitle: Text(items[index]),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        // showDialog(
                        //   context: context,
                        //   builder: (BuildContext context) {
                        //     return AlertDialog(
                        //       title: Text('Item $index'),
                        //       content: Text('You have tapped item $index.'),
                        //       actions: <Widget>[
                        //         OutlinedButton(
                        //           child: Text('OK'),
                        //           onPressed: () {
                        //             Navigator.of(context).pop();
                        //           },
                        //         ),
                        //       ],
                        //     );
                        //   },
                        // );
                        if (index < _buildList.length) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => _buildList[index],
                            ),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Item $index'),
                                content: Text('You have tapped item $index.'),
                                actions: <Widget>[
                                  OutlinedButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                );
              },
              childCount: items.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child: Icon(Icons.add),
      ),
    );
  }
}



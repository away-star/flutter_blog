import 'package:flutter/material.dart';
import 'package:my_blog/pages/home/fun.dart';


class MyAction extends StatelessWidget {
  const MyAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.stars_outlined, color: Colors.black),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return FunWidgetsPage();
            }));
          },
        ),
      ],
    );
  }
}

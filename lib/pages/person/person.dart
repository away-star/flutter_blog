import 'package:flutter/material.dart';

class Person extends StatefulWidget {
  const Person({Key? key}) : super(key: key);

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
                  right: 2,
                  top: 2,
                  child: IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.clear),
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
                      'xingxing',
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
                          color: Colors.grey[700], size: 20),
                      SizedBox(width: 5),
                      Text(
                        '2064989403@qq.com',
                        style: TextStyle(
                          color: Colors.grey[700],
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
                          color: Colors.grey[700], size: 20),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          'So far all life is written with failure, but this does not prevent me from moving forward',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.grey[500],
                            fontSize: 18,
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
                          color: Colors.grey[700], size: 20),
                      SizedBox(width: 5),
                      Text(
                        '三体环境下的一颗太阳上',
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),
                      ),
                      Text(
                        '(未授权定位)',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.code_sharp, color: Colors.grey[700], size: 20),
                      SizedBox(width: 5),
                      Text(
                        'https://github.com/user.name',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ],
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

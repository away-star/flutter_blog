import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 155.0,
                  //! 这里选择logo
                  child: Image.network(
                    "https://www.itying.com/images/flutter/1.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 45.0),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: '电子邮箱',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                  ),
                ),
                SizedBox(height: 25.0),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: '密码',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                  ),
                ),
                SizedBox(
                  height: 35.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('登录'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // 按钮的颜色
                      onPrimary: Colors.white, // 文本的颜色
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                  )

                ),
                SizedBox(
                  height: 15.0,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "还没有账号？点击注册",
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w300),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

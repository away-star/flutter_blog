import 'package:flutter/material.dart';
import 'package:my_blog/pages/home/home.dart';
import 'package:my_blog/pages/person/person.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.transparent,
      ),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/home':
            return MaterialPageRoute(builder: (context) => Home());
          // case '/person':
          //   return MaterialPageRoute(builder: (context) => Person());
          default:
            return null;
        }
      },
      home: Home(),
    );
  }
}

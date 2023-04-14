import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_blog/pages/checkIn/login_screen.dart';
import 'package:my_blog/pages/checkIn/transition_route_observer.dart';
import 'package:my_blog/pages/home/home.dart';
import 'package:my_blog/pages/person/person.dart';
import 'package:my_blog/services/apiInterceptor.dart';
import 'package:provider/provider.dart';
import 'models/apiProvider.dart';

void main() {
  Dio dio = Dio();
  dio.interceptors.add(ApiInterceptor());
  runApp(MyApp(dio: dio));
}

class MyApp extends StatelessWidget {
  final Dio dio;

  MyApp({required this.dio, Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: Colors.orange),
        // fontFamily: 'SourceSansPro',
        textTheme: TextTheme(
          displaySmall: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 45.0,
            // fontWeight: FontWeight.w400,
            color: Colors.orange,
          ),
          labelLarge: const TextStyle(
            // OpenSans is similar to NotoSans but the uppercases look a bit better IMO
            fontFamily: 'OpenSans',
          ),
          bodySmall: TextStyle(
            fontFamily: 'NotoSans',
            fontSize: 12.0,
            fontWeight: FontWeight.normal,
            color: Colors.deepPurple[300],
          ),
          displayLarge: const TextStyle(fontFamily: 'Quicksand'),
          displayMedium: const TextStyle(fontFamily: 'Quicksand'),
          headlineMedium: const TextStyle(fontFamily: 'Quicksand'),
          headlineSmall: const TextStyle(fontFamily: 'NotoSans'),
          titleLarge: const TextStyle(fontFamily: 'NotoSans'),
          titleMedium: const TextStyle(fontFamily: 'NotoSans'),
          bodyLarge: const TextStyle(fontFamily: 'NotoSans'),
          bodyMedium: const TextStyle(fontFamily: 'NotoSans'),
          titleSmall: const TextStyle(fontFamily: 'NotoSans'),
          labelSmall: const TextStyle(fontFamily: 'NotoSans'),
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(secondary: Colors.orange),
      ),
      navigatorObservers: [TransitionRouteObserver()],
      // theme: ThemeData(
      //   primaryColor: Colors.transparent,
      // ),
      // theme: ThemeData(
      //   primarySwatch: Colors.deepPurple,
      //   accentColor: Colors.orange,
      //   //cursorColor: Colors.orange,
      //   textTheme: TextTheme(
      //     headline3: TextStyle(
      //       fontFamily: 'OpenSans',
      //       fontSize: 45.0,
      //       color: Colors.orange,
      //     ),
      //     button: TextStyle(
      //       fontFamily: 'OpenSans',
      //     ),
      //     subtitle1: TextStyle(fontFamily: 'NotoSans'),
      //     bodyText2: TextStyle(fontFamily: 'NotoSans'),
      //   ),
      // ),
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
      home: LoginScreen(),
    );
  }
}

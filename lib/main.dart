import 'package:flutter/material.dart';
import 'package:test_app_001/widgets/Login.dart';
import 'package:test_app_001/widgets/MainWidget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),
        '/main': (context) => MainWidget(),
      },
    );
  }
}
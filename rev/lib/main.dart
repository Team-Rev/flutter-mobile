import 'package:flutter/material.dart';
import 'package:rev/pages/auth/find_page.dart';
import 'package:rev/pages/auth/login_page.dart';
import 'package:rev/pages/auth/register_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      // theme: ThemeData(
      //   primarySwatch: Colors.green,
      // ),
      home: LoginPage(),
    );

  }
}
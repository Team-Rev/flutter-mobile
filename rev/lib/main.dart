import 'package:flutter/material.dart';
import 'package:flutter_new/Screens/auth/auth_login.dart';
import 'package:flutter_new/Screens/default/default.dart';
import 'package:flutter_new/repo/ask.dart';
import 'package:flutter_new/repo/boards.dart';
import 'package:flutter_new/repo/problems.dart';
import 'package:flutter_new/themes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BoardProvider()),
        ChangeNotifierProvider(create: (_) => AskProvider()),
        ChangeNotifierProvider(
          create: (_) => QuestionProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/auth',
        routes: {
          '/auth': (context) =>AuthLogin(),
          '/': (context) => DefaultPage(),
        },
        // home: AuthLogin(),
        title: 'OnePass Login Page',
        theme: CustomTheme.lightTheme,
        darkTheme: CustomTheme.darkTheme,
        themeMode: currentTheme.currentTheme,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rev/pages/auth/auth_page.dart';
import 'package:rev/pages/main/main_page.dart';
import 'package:rev/provider/provider_auth.dart';
import 'package:rev/provider/provider_main.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => MainProvider()),
      ],
      child: MaterialApp(
        // title: 'Flutter Demo',
        // theme: ThemeData(
        //   primarySwatch: Colors.green,
        // ),
        home: Consumer<AuthProvider>(
          builder: (context, provider, child) {
            return Navigator(
              onPopPage: (route, result) {
                if (!route.didPop(result)) return false;
                return true;
              },
              pages: [
                AuthPage(),
                if (provider.currentPage == '1')
                  MaterialPage(
                    key: ValueKey(MainWidget().pageName), // 세션ID?
                    child: MainWidget(),
                  )
              ],
            );
          },
        ),
      ),
    );
  }
}

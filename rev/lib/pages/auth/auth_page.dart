import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rev/color_rev.dart';
import 'package:rev/pages/auth/register_page.dart';
import 'package:rev/provider/provider_auth.dart';

import 'find_page.dart';
import 'login_page.dart';

class AuthPage extends Page {
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        settings: this, builder: (context) => AuthWidget());
  }
}

class AuthWidget extends StatelessWidget {
  AuthProvider _authProvider;

  @override
  Widget build(BuildContext context) {
    _authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorRev.g1,
      body: Padding(padding:EdgeInsets.symmetric(horizontal: 16.0), child: selectPage()),
    );
  }

  Widget selectPage() {
    switch (_authProvider.currentPage) {
      case 'FindPage':
        return FindPage();
      case 'RegisterPage':
        return RegisterPage();
    }
    return LoginPage();
  }
}

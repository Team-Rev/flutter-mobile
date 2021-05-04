import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rev/util/color_rev.dart';
import 'package:rev/pages/auth/auth_register.dart';
import 'package:rev/provider/provider_auth.dart';

import 'auth_find.dart';
import 'auth_login.dart';

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
      backgroundColor: ColorRev.g3,
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0), child: selectPage()),
    );
  }

  Widget selectPage() {
    switch (_authProvider.currentPage) {
      case 'AuthFind':
        return AuthFind();
      case 'AuthRegister':
        return AuthRegister();
    }
    return AuthLogin();
  }
}

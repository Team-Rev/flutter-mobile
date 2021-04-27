import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rev/color_rev.dart';
import 'package:rev/provider/provider_main.dart';

class MainPage extends Page {
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        settings: this, builder: (context) => MainWidget());
  }
}

class MainWidget extends StatelessWidget {
MainProvider _mainProvider;
  @override
  Widget build(BuildContext context) {
    _mainProvider = Provider.of<MainProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorRev.g3,
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0), child: selectPage()),
    );
  }
  Widget selectPage() {
    return Container();
  }
}

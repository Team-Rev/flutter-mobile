import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rev/util/color_rev.dart';
import 'package:rev/pages/main/main_default.dart';
import 'package:rev/pages/main/main_profile.dart';
import 'package:rev/pages/main/main_test/test_main.dart';
import 'package:rev/provider/provider_main.dart';

import 'main_test/test_question_select.dart';


class MainPage extends Page {
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        settings: this, builder: (context) => MainWidget());
  }
}

class MainWidget extends StatelessWidget {
  final String pageName="MainPage";
  MainProvider _mainProvider;

  @override
  Widget build(BuildContext context) {
    _mainProvider = Provider.of<MainProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorRev.g3,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _navigationBody(),
      ),
      bottomNavigationBar: _bottomNavigationBarWidget(),
    );
  }
  Widget _navigationBody() {
    switch(_mainProvider.currentPage) {
      case 0:
        return MainProfile();
      case 1:
        return MainDefault();
      case 2:
        return MainTest();
      // case 3:
      //   return SelectQuestion();
    }
    return Container();
  }
  Widget _bottomNavigationBarWidget() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.account_circle),activeIcon:Icon(Icons.account_circle_outlined),label: 'Profile'),
        BottomNavigationBarItem(icon: Icon(Icons.assignment),activeIcon:Icon(Icons.assignment_outlined),label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.wb_incandescent),activeIcon:Icon(Icons.wb_incandescent_outlined),label: 'Study'),
      ],
      currentIndex: _mainProvider.currentPage,
      selectedItemColor: ColorRev.g3,
      onTap: (index) {
        _mainProvider.updateState(index);
      },
    );
  }
}
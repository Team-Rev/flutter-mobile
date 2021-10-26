import 'package:flutter/material.dart';
import 'package:flutter_new/Screens/default/profile/profile.dart';
import 'package:flutter_new/Screens/default/study/study_widget.dart';
import 'package:flutter_new/constraints.dart';

import 'home/home_widget.dart';

class DefaultPage extends StatefulWidget {
  @override
  _DefaultPageState createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {
  static int pageNum=0;
  PageController controller;

  @override
  Widget build(BuildContext context) {
    controller = PageController(initialPage: pageNum);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _navigationBody(),
      ),
      bottomNavigationBar: _bottomNavigationBarWidget(),
    );
  }

  Widget _navigationBody() {
    return PageView(
      physics: BouncingScrollPhysics(),
      onPageChanged:(index) {setState(() {
        pageNum=index;
      });},
      scrollDirection: Axis.horizontal,
      controller: controller,
      children: [
        Profile(),
        Home(),
        Study()
      ],
    );
  }

  Widget _bottomNavigationBarWidget() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            activeIcon: Icon(Icons.account_circle_outlined),
            label: 'Profile'),
        BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            activeIcon: Icon(Icons.assignment_outlined),
            label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.wb_incandescent),
            activeIcon: Icon(Icons.wb_incandescent_outlined),
            label: 'Study'),
      ],
      currentIndex: pageNum,
      selectedItemColor: primaryColor,
      onTap: (index) {
        setState(() {
          pageNum=index;
        });
        controller.jumpToPage(index);
      },
    );
  }
}

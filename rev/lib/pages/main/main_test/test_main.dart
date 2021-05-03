import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../dio_server.dart';
import '../../../reusable.dart';
import 'Test_Question.dart';


class TestPage extends Page {
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        settings: this, builder: (context) => MainTest());
  }
}

class MainTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            elevation: 7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '당신은 잘 하고 있습니다!',

                    ),
                    Text('오늘도 파이팅 !',
                        style:
                        TextStyle(fontSize: 32, fontWeight: FontWeight.bold),),
                  ],
                ),
                SizedBox(
                  width: 30,
                ),
                Icon(
                  Icons.accessibility,
                  size: 128,
                ),
              ],
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 84,
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            elevation: 7,
            child: ReUsable.buildTextButton4('문제 풀기', () {
              server.getReq();
              Navigator.push(context, MaterialPageRoute(builder: (context) =>TestQuestion()));

            }, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 84,
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            elevation: 7,
            child: ReUsable.buildTextButton4('키워드 선택 풀기', () {
              server.getReq();
            }, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 84,
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            elevation: 7,
            child: ReUsable.buildTextButton4('문제기록 보기', () {
              server.getReq();
            }, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 84,
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            elevation: 7,
            child: ReUsable.buildTextButton4('문의하기', () {
              server.getReq();
            }, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}

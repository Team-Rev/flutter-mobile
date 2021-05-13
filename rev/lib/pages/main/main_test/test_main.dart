import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rev/pages/main/main_profile.dart';
import 'package:rev/pages/main/main_test/test_question_select.dart';
import 'package:rev/pages/main/main_test/test_showresult.dart';
import 'package:rev/pages/main/main_test/test_showresult_detail.dart';
import 'package:rev/provider/provider_main.dart';
import 'package:rev/provider/provider_test.dart';

import '../../../dio_server.dart';
import '../../../util/reusable.dart';


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
                  Icons.account_circle_sharp,
                  color: Colors.grey,
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
            child: Consumer<MainProvider>(
              builder: (context,provider,child) {
                return ReUsable.buildTextButton4('문제 풀기', () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>SelectQuestion()));
                  // provider.updateCurrentQuestion(0);
                  // server.getReqToQuery(context,'getQuestionByRange',start: 1,end: 5);
                  // Navigator.push(context, MaterialPageRoute(builder: (context) =>TestQuestion()));

                }, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold));
              },
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
            child: ReUsable.buildTextButton4('키워드 선택 풀기', () {
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
              server.getReqToQuery(context, 'getResults');
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
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ResultDetail()));
            }, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}

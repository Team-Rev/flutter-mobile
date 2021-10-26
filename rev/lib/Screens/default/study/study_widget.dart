import 'package:flutter/material.dart';
import 'package:flutter_new/Screens/default/study/select.dart';
import 'package:flutter_new/Screens/default/study/study_result.dart';

import '../../../constraints.dart';
import '../../../server.dart';

class Study extends StatelessWidget {
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
                    Text(
                      '오늘도 파이팅 !',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
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
            child: buildPrimaryTextOnlyButton(
              context,
              Text('문제 풀기',
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>SelectQuestion()));
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
            child: buildPrimaryTextOnlyButton(
              context,
              Text('키워드 선택 풀기',
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              () {},
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
            child: buildPrimaryTextOnlyButton(
              context,
              Text('문제기록 보기',
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              () {
                server.getReq('getResults', page: 0);
                Future.delayed(Duration(seconds: 1), () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ShowResult()));
                });
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
            child: buildPrimaryTextOnlyButton(
              context,
              Text('문의하기',
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              () {},
            ),
          ),
        ),
      ],
    );
  }
}

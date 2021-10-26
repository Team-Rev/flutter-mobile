import 'package:flutter/material.dart';
import 'package:flutter_new/constraints.dart';
import 'package:flutter_new/server.dart';

import '../../../secret.dart';

class Profile extends StatelessWidget {
  TextEditingController temp;

  @override
  Widget build(BuildContext context) {
    temp = TextEditingController(text: Secret.token);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${Secret.nickname}님 반갑습니다!'),
                  buildTextFormField(context, temp, null, null),
                  Text(
                      '\n해석하면 \n\nUserId : ${Secret.getSub}\nIAT : ${Secret.getIat}\nEXP : ${Secret.getExp}'),
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
              child: Center(
                child: Text('${Secret.nickname} 님의 프로필',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
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
                Text('프로필 수정',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                () {server.getReq('getProfile', context: context);},
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
                Text('포인트 조회',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                () {server.getReq('getPointList',context: context);},
              ),
            ),
          ),
        ],
      ),
    );
  }
}

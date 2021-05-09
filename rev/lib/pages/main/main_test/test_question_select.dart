import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rev/provider/provider_test.dart';
import 'package:rev/util/color_rev.dart';
import 'package:rev/util/reusable.dart';

import '../../../dio_server.dart';

// provider.updateCurrentQuestion(0);
// server.getReqToQuery(context,'getQuestionByRange',start: 1,end: 5);
// Navigator.push(context, MaterialPageRoute(builder: (context) =>TestQuestion()));

class SelectQuestion extends StatelessWidget {
  TextEditingController _startController;
  TextEditingController _endController;

  @override
  Widget build(BuildContext context) {
    _startController = TextEditingController();
    _endController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorRev.g3,
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 24),
          height: 300,
          alignment: Alignment.center,
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      "응시할 문제의 범위를 입력하시오",
                      style: TextStyle(fontSize: 20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.west),
                        Icon(Icons.east),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                            width: 100,
                            child: ReUsable.buildTextFormField(
                                _startController, null, '시작번호',
                                keyboardType: TextInputType.number)),
                        SizedBox(
                            width: 100,
                            child: ReUsable.buildTextFormField(
                                _endController, null, '끝번호',
                                keyboardType: TextInputType.number)),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Consumer<QuestionProvider>(
                        builder: (context, provider, child) {
                          return ReUsable.buildTextButton2('풀기 시작', () {
                            provider.updateCurrentQuestion(0);
                            server.getReqToQuery(context, 'getQuestionByRange',
                                start:
                                    int.parse(_startController.text.toString()),
                                end: int.parse(_endController.text.toString()));
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => TestQuestion()));
                          });
                        },
                      ),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

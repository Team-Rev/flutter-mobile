import 'package:flutter/material.dart';
import 'package:flutter_new/constraints.dart';
import 'package:flutter_new/server.dart';

class SelectQuestion extends StatelessWidget {
  TextEditingController _startController;
  TextEditingController _endController;

  @override
  Widget build(BuildContext context) {
    _startController = TextEditingController();
    _endController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryColor,
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
                          child: buildTextFormField(
                              context, _startController, null, '시작번호',
                              keyboardType: TextInputType.number),
                        ),
                        SizedBox(
                          width: 100,
                          child: buildTextFormField(
                              context, _endController, null, '끝번호',
                              keyboardType: TextInputType.number),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: buildTextButton(context, Text('문제 풀기'), () {
                        server.getReq('getQuestionByRange',
                            start: int.parse(_startController.text),
                            end: int.parse(_endController.text),
                            context: context);
                      }),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

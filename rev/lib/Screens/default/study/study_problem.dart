import 'package:flutter/material.dart';
import 'package:flutter_new/constraints.dart';
import 'package:flutter_new/repo/problems.dart';
import 'package:provider/provider.dart';

import '../../../server.dart';

class TestQuestion extends StatelessWidget {
  QuestionProvider _questionProvider;

  List<Widget> getAnsweer(List<String> index) {
    print("hi $index");
    List<Widget> result = [];

    for (int i = 0; i < index.length; i++) {
      result.add(Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () {
                if (Questions.submitList[_questionProvider.currentQ]
                    .contains(
                    Questions.answerList[_questionProvider.currentQ]
                    [index[i].toString()]))
                  Questions.submitList[_questionProvider.currentQ]
                      .remove(Questions
                      .answerList[_questionProvider.currentQ]
                  [index[i].toString()]);
                else
                  Questions.submitList[_questionProvider.currentQ].add(
                      Questions.answerList[_questionProvider.currentQ]
                      [index[i].toString()]);
                _questionProvider.notifyListeners();
              },
              child: Text(
                '${i + 1}. ${index[i].toString()}',
                style: TextStyle(fontSize: 20),
              ),
              style: TextButton.styleFrom(
                  alignment: Alignment.centerLeft,
                  primary: Questions
                      .submitList[_questionProvider.currentQ]
                      .contains(Questions
                      .answerList[_questionProvider.currentQ]
                  [index[i].toString()])
                      ? primaryColor
                      : Colors.black,
                  backgroundColor: Colors.transparent),
            ),
          ),
        ],
      ));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    _questionProvider = Provider.of<QuestionProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          verticalDirection: VerticalDirection.up,
          children: [
            SizedBox(
              height: 16,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              //카드 색
              color: textPrimaryColor,
              elevation: 7,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 7),
                child: Column(
                  children: [
                    ButtonBar(
                      alignment: MainAxisAlignment.spaceAround,
                      children: [
                        buildTextButton(context, Text('이전'), () {_questionProvider.previousQ();}),
                        buildTextButton(context, Text('찜 ❤'), () {}),
                        buildTextButton(context, Text('다음'), () {_questionProvider.nextQ();}),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          width: MediaQuery.of(context).size.width * 0.43,
                          height: 20,
                          child: LinearProgressIndicator(
                            value: _questionProvider.currentQ /
                                Questions.questionList.length +
                                1 / Questions.questionList.length,
                            valueColor:
                            AlwaysStoppedAnimation<Color>(primaryColor),
                            backgroundColor: Colors.grey,
                          ),
                        ),
                        buildTextButton(context, Text('제출'), () {server.getReq('submit',context: context);}),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 64,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              //카드 색
              color: textPrimaryColor,
              elevation: 7,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                child: Column(
                  children: getAnsweer(Questions
                      .answerList[_questionProvider.currentQ].keys
                      .toList()),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              //카드 색
              color: textPrimaryColor,
              elevation: 7,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        Questions
                            .questionList[_questionProvider.currentQ],
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

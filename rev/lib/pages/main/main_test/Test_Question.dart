import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rev/provider/provider_test.dart';
import 'package:rev/provider/questions.dart';

import '../../../color_rev.dart';
import '../../../dio_server.dart';
import '../../../reusable.dart';

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
                if (Questions.submitList[_questionProvider.currentQuestion]
                    .contains(
                        Questions.answerList[_questionProvider.currentQuestion]
                            [index[i].toString()]))
                  Questions.submitList[_questionProvider.currentQuestion]
                      .remove(Questions
                              .answerList[_questionProvider.currentQuestion]
                          [index[i].toString()]);
                else
                  Questions.submitList[_questionProvider.currentQuestion].add(
                      Questions.answerList[_questionProvider.currentQuestion]
                          [index[i].toString()]);
                _questionProvider.notifyListeners();
              },
              child: Text(index[i].toString()),
              style: TextButton.styleFrom(
                  alignment: Alignment.centerLeft,
                  primary: Questions
                          .submitList[_questionProvider.currentQuestion]
                          .contains(Questions
                                  .answerList[_questionProvider.currentQuestion]
                              [index[i].toString()])
                      ? ColorRev.g3
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
      backgroundColor: ColorRev.g1,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              height: 64,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              //카드 색
              color: ColorRev.white,
              elevation: 7,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        Questions
                            .questionList[_questionProvider.currentQuestion],
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              //카드 색
              color: ColorRev.white,
              elevation: 7,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                child: Column(
                  children: getAnsweer(Questions
                      .answerList[_questionProvider.currentQuestion].keys
                      .toList()),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              //카드 색
              color: ColorRev.white,
              elevation: 7,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ButtonBar(
                      alignment: MainAxisAlignment.spaceAround,
                      children: [
                        ReUsable.buildTextButton2('이전 문제', () {
                          _questionProvider.previousCurrentQuestion();
                        }),
                        ReUsable.buildTextButton2('문제 찜❤', () {}),
                        ReUsable.buildTextButton2('다음 문제', () {
                          _questionProvider.nextCurrentQuestion();
                        }),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          width: MediaQuery.of(context).size.width * 0.45,
                          height: 20,
                          child: LinearProgressIndicator(
                            value: _questionProvider.currentQuestion /
                                    Questions.questionList.length +
                                1 / Questions.questionList.length,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(ColorRev.g3),
                            backgroundColor: Colors.grey,
                          ),
                        ),
                        ReUsable.buildTextButton2("제출", () {
                          server.postReq(context, () {}, 'submit');
                        })
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

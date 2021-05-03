import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rev/pages/main/main_test/answerbutton.dart';
import 'package:rev/provider/provider_answer.dart';
import 'package:rev/provider/provider_test.dart';
import 'package:rev/provider/questions.dart';

import '../../../color_rev.dart';
import '../../../reusable.dart';

class TestQuestion extends StatelessWidget {
  QuestionProvider _questionProvider;
  AnswerProvider _answerProvider;
  List<Map<String, int>> answerList = [];
  List<String> temp;

  List<Widget> buildButtons() {
    temp =
        answerList[_questionProvider.currentQuestion].keys.toList();
    List<Widget> result = [];
    for (int i = 0;
    i < answerList[_questionProvider.currentQuestion].length;
    i++) {
      result.add(
        Row(
          children: [
            Expanded(
                child:
                AnswerButton(temp[i], _questionProvider.currentQuestion)),
          ],
        ),
      );
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    _questionProvider = Provider.of<QuestionProvider>(context,listen: false);
    Questions.init(Questions.question);
    answerList = Questions.answerList;

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
                        Questions.questionList[_questionProvider.currentQuestion],
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
                  children: buildButtons(),
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
                          buildButtons();
                          _questionProvider.previousCurrentQuestion();
                        }),
                        ReUsable.buildTextButton2('문제 찜❤', () {}),
                        ReUsable.buildTextButton2('다음 문제', () {
                          buildButtons();
                          _questionProvider.nextCurrentQuestion();
                        }),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.45,
                          height: 20,
                          child: LinearProgressIndicator(
                            value: _questionProvider.currentQuestion /
                                Questions.questionLength +
                                0.1,
                            valueColor:
                            AlwaysStoppedAnimation<Color>(ColorRev.g3),
                            backgroundColor: Colors.grey,
                          ),
                        ),
                        ReUsable.buildTextButton2("제출", () {})
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

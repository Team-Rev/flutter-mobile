import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rev/provider/questions.dart';

class QuestionProvider extends ChangeNotifier {
  int _currentQuestion = 0;
  // List<int> _answerNum;
  // List<int> get answerNum=>_answerNum;
  int get currentQuestion => _currentQuestion;
  // void answerInit(int temp) {
  //   _answerNum=List.generate(Questions.answerList[temp].length, (index) => index);
  // }
  // void answerPop() {
  //   _answerNum.removeAt(0);
  // }
  void updateCurrentQuestion(int state) {
    _currentQuestion = state;
    notifyListeners();
  }

  void previousCurrentQuestion() {
    if (_currentQuestion > 0) _currentQuestion -= 1;
    // _answerNum=List.generate(Questions.answerList[_currentQuestion].length, (index) => index);
    notifyListeners();
  }

  void nextCurrentQuestion() {
    if (_currentQuestion < Questions.questionList.length - 1) _currentQuestion += 1;
    // _answerNum=List.generate(Questions.answerList[_currentQuestion].length, (index) => index);
    notifyListeners();
  }
}

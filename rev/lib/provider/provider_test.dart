import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rev/provider/questions.dart';

class QuestionProvider extends ChangeNotifier {
  int _currentQuestion = 0;

  int get currentQuestion => _currentQuestion;

  void updateCurrentQuestion(int state) {
    _currentQuestion = state;
    notifyListeners();
  }

  void previousCurrentQuestion() {
    if (_currentQuestion > 0) _currentQuestion -= 1;
    notifyListeners();
  }

  void nextCurrentQuestion() {
    if (_currentQuestion < Questions.questionLength - 1) _currentQuestion += 1;
    notifyListeners();
  }
}

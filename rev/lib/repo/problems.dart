
import 'package:flutter/material.dart';

class Questions {
  static List<String> _QList = [];
  static get questionList => _QList;

  static List<Map<String, int>> _AList = [];
  static get answerList => _AList;

  static List<List<int>> _SList = [];
  static get submitList => _SList;

  static List<int> _QNList = [];
  static get questionNumList => _QNList;

  static Map<String, dynamic> _QResult;
  static get questionResult => _QResult;

  static void initQResult(dynamic value) {
    _QResult=value;
  }

  static void init(dynamic value) {
    _Q.clear();
    _QList.clear();
    _AList.clear();
    _SList.clear();
    _Q=value;
    if(_SList.length==0)
      for(int i=0;i<value.length;i++) {
        _SList.add([]);
        _QNList.add(value[i]["id"]);
      }
    for (int i = 0; i < value.length; i++) {
      _QList.add(value[i]["exam"]);

      Map<String, int> answer = {};
      for (int j = 0; j < value[i]["choices"].length; j++) {
        answer.addAll(
            {value[i]["choices"][j]["choice"]: value[i]["choices"][j]["id"]});
      }
      _AList.add(answer);
    }
    print("answerList : $_AList");
    for(int i=0;i<_AList.length;i++)
      print("answerList : ${answerList[i]}");
    print("submitValue : $_SList");
  }

  static var _Q =[];
  static get question=>_Q;
}
class Results {
  static var _resultSummary = [];

  static get resultSummary => _resultSummary;

  static var _resultQuestions=[];
  static get resultQuestion=>_resultQuestions;
  //TODO 객체 메소드 안에 넣을 수 있을거같은데?
  static bool isEmptySummary() {
    if(_resultSummary.isEmpty) return true;
    return false;
  }
  static void initResultSummary(var value) {
    _resultSummary = value;
    print(_resultSummary);
    print('ResultSummary init clear');
  }
  static void initResultQuestions(var value) {
    _resultQuestions = value;
    print(_resultQuestions);
  }

}


class QuestionProvider extends ChangeNotifier {
  int _currentQ = 0;

  int get currentQ => _currentQ;

  void updateQ(int state) {
    _currentQ = state;
    notifyListeners();
  }

  void previousQ() {
    if (_currentQ > 0) _currentQ -= 1;
    notifyListeners();
  }

  void nextQ() {
    if (_currentQ < Questions.questionList.length - 1)
      _currentQ += 1;
    notifyListeners();
  }
}

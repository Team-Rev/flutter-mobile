import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rev/provider/provider_answer.dart';
import 'package:rev/provider/questions.dart';

import '../../../color_rev.dart';

class AnswerButton extends StatefulWidget {
  String name;
  int currentQuestion=0;
  AnswerButton(String name, int currentQuestion) {
    this.name=name;
    currentQuestion=currentQuestion;
  }
  @override
  _AnswerButtonState createState() => _AnswerButtonState(name, currentQuestion);
}

class _AnswerButtonState extends State<AnswerButton> {
  AnswerProvider _answerProvider;
  int currentQuestion=0;
  bool _isChecked=false;
  String name;
  List<int> temp;
  _AnswerButtonState(String name, int currentQuestion) {
    this.name=name;
    currentQuestion=currentQuestion;
  }
  @override
  Widget build(BuildContext context) {
    _answerProvider=Provider.of<AnswerProvider>(context);
    temp=Questions.submitList[currentQuestion];
    _isChecked=check();
    print(temp);
    print(Questions.answerList[currentQuestion]);
    return TextButton(
        onPressed: (){
        setState(() {
          toggle();
        });
      },
      child: Text(name),
      style: TextButton.styleFrom(
        alignment: Alignment.centerLeft,
          primary: _isChecked ? ColorRev.g3 : Colors.black,
          backgroundColor: Colors.transparent),
    );
  }
  bool check() {
    for(int i=0;i<temp.length;i++)
    if(temp[i]!=0&&temp[i]==Questions.answerList[currentQuestion][name])
      return true;
    return false;
  }
  void toggle() {
    if (_isChecked) {
      if(check()) {
        temp.remove(Questions.answerList[currentQuestion][name]);
        _isChecked = false;
      }
      // Questions.submitList[currentQuestion].add(Questions.answerList[currentQuestion]["${widget.name}"]);
    }
    else {
      temp.add(Questions.answerList[currentQuestion][name]);
      _isChecked = true;
    }

  }
}


// class AnswerButton extends StatefulWidget {
//   @override
//   AnswerButtonStatus createState() =>AnswerButtonStatus();
//
// }
//
// class AnswerButtonStatus extends State<AnswerButton> {
//   static bool _isChecked = false;
//
//   @Override
//
//   static build(child) {
//     return TextButton(
//       onPressed: () {
//         toggle();
//       },
//       child: child,
//       style: TextButton.styleFrom(
//           primary: _isChecked ? ColorRev.g1 : Colors.black,
//           backgroundColor: Colors.transparent),
//     );
//   }
//
//   static void toggle() {
//     if (_isChecked)
//       _isChecked = false;
//     else
//       _isChecked = true;
//   }
// }

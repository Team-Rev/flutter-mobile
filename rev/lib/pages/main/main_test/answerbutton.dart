import 'package:flutter/material.dart';

import '../../../color_rev.dart';

class AnswerButton extends StatefulWidget {
  String name;
  AnswerButton(String name) {
    this.name=name;
  }
  @override
  _AnswerButtonState createState() => _AnswerButtonState();
}

class _AnswerButtonState extends State<AnswerButton> {
  bool _isChecked=false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
        setState(() {
          toggle();
        });
      },
      child: Text(widget.name),
      style: TextButton.styleFrom(
        alignment: Alignment.centerLeft,
          primary: _isChecked ? ColorRev.g3 : Colors.black,
          backgroundColor: Colors.transparent),
    );
  }
  void toggle() {
    if (_isChecked)
      _isChecked = false;
    else
      _isChecked = true;
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

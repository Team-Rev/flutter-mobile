// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:rev/provider/provider_test.dart';
// import 'package:rev/reusable.dart';
//
// import '../../../color_rev.dart';
//
// class Tes1tQuestion extends StatelessWidget {
//   final pageName = 'TestQuestion';
//
//   QuestionProvider _questionProvider;
//   List<bool> isSelected;
//
//   @override
//   Widget build(BuildContext context) {
//     _questionProvider = Provider.of<QuestionProvider>(context);
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: ColorRev.g1,
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 16),
//         child: Column(
//           children: [
//             SizedBox(
//               height: 64,
//             ),
//             Card(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(32)),
//               //카드 색
//               color: ColorRev.white,
//               elevation: 7,
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       padding: EdgeInsets.symmetric(vertical: 16),
//                       child: Text(
//                         Questions.getQuestionExam(
//                             _questionProvider.currentQuestion),
//                         overflow: TextOverflow.clip,
//                       ),
//                     ),
//                     Container(
//                       child: ListView.builder(
//                         itemCount: Questions.currentQuestionChoice(_questionProvider.currentQuestion).length,
//                         itemBuilder: (context, index) {
//                           return ListTile(onTap: () {},title: Text('test'),);
//                         },
//                       ),
//                     ),
//                     ButtonBar(
//                       alignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         ReUsable.buildTextButton2('이전 문제', () {
//                           _questionProvider.previousCurrentQuestion();
//                         }),
//                         ReUsable.buildTextButton2('문제 찜❤', () {}),
//                         ReUsable.buildTextButton2('다음 문제', () {
//                           _questionProvider.nextCurrentQuestion();
//                         }),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Container(
//                           margin: EdgeInsets.symmetric(vertical: 5),
//                           width: MediaQuery.of(context).size.width * 0.45,
//                           height: 20,
//                           child: LinearProgressIndicator(
//                             value: _questionProvider.currentQuestion /
//                                     Questions.questionLength +
//                                 0.1,
//                             valueColor:
//                                 AlwaysStoppedAnimation<Color>(ColorRev.g3),
//                             backgroundColor: Colors.grey,
//                           ),
//                         ),
//                         ReUsable.buildTextButton2("제출", () {})
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

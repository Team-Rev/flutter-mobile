import 'package:flutter/material.dart';
import 'package:flutter_new/constraints.dart';
import 'package:flutter_new/repo/problems.dart';

class ResultDetail extends StatelessWidget {
  const ResultDetail({Key key}) : super(key: key);

  List<Widget> getAnsweer(int index) {
    List<Widget> result = [];

    for (int i = 0;
        i < Results.resultQuestion[index]['question']['choices'].length;
        i++) {
      Color temp = Colors.black;
      if (Results.resultQuestion[index]['question']['choices'][i]
              ['isCorrect'] ==
          true) temp = Colors.red;
      for (int j = 0;
          j < Results.resultQuestion[index]['choices'].length;
          j++) {
        if (Results.resultQuestion[index]['question']['choices'][i]['id'] ==
            Results.resultQuestion[index]['choices'][j]) {
          if (Results.resultQuestion[index]['question']['choices'][i]
                  ['isCorrect'] ==
              true) {
            temp = Colors.blue;
            break;
          }
          temp = primaryColor;
          break;
        }
      }

      result.add(Row(
        children: [
          Expanded(
            child: Text(
              '${i + 1}. ${Results.resultQuestion[index]['question']['choices'][i]['choice'].toString()}',
              style: TextStyle(fontSize: 20, color: temp),
            ),
          ),
        ],
      ));
    }
    return result;
  }

  Widget _buildResultDetail(context, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ListView.builder(
                //     itemCount:Results.resultQuestion[index]['keywords'].length,
                //     itemBuilder: (context, index2) {
                //   int itemCount = 1;
                //   if (itemCount > 0) return buildTextButton(context, Text(Results.resultQuestion[index]['keywords'][index2]), () {});
                //   return Center(
                //     child: Text(
                //       '기록이 없습니다.',
                //       style: TextStyle(
                //           fontSize: 24,
                //           color: Colors.grey,
                //           fontWeight: FontWeight.bold),
                //     ),
                //   );
                // }),
                Wrap(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      color: primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(Results.resultQuestion[index]['keywords'][0],style: TextStyle(color: Colors.white),),
                      ),
                    ),

                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      color: primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(Results.resultQuestion[index]['keywords'][1],style: TextStyle(color: Colors.white),),
                      ),
                    ),

                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      color: primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(Results.resultQuestion[index]['keywords'][2],style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ],
                ),
                Text(
                  Results.resultQuestion[index]['question']['exam'].toString(),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Column(
                  children: getAnsweer(index),
                ),
                SizedBox(
                  height: 8,
                ),
                Divider(
                  height: 8,
                  thickness: 1,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 4,
                ),
                Text(
                  '문제 기록',
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Card(
                  color: secondaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          color: Colors.blue,
                        ),
                        Text(' Correct'),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 10,
                          height: 10,
                          color: Colors.red,
                        ),
                        Text(' Actual'),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 10,
                          height: 10,
                          color: primaryColor,
                        ),
                        Text(' Your Select'),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.8,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              elevation: 7,
              child: ListView.builder(
                itemCount: Results.resultQuestion.length,
                itemBuilder: (context, index) {
                  int itemCount = 1;
                  if (itemCount > 0) return _buildResultDetail(context, index);
                  return Center(
                    child: Text(
                      '기록이 없습니다.',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }
}

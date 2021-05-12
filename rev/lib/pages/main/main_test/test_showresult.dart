import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rev/repository/test_results.dart';
import 'package:rev/util/color_rev.dart';

class ShowResult extends StatelessWidget {
  const ShowResult({Key key}) : super(key: key);

  Widget _buildResult(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Results.resultList[index]['categoryMain']
                                .toString(),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            Results.resultList[index]['categorySub'].toString(),
                            style: TextStyle(fontSize: 10),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${Results.resultList[index]['answerMain']['totalCount'].toString()}/${Results.resultList[index]['answerMain']['correctCount'].toString()}',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            Results.resultList[index]['answerMain']['date']
                                .toString(),
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    TextButton(
                      child: Icon(Icons.arrow_forward_ios),
                      onPressed: () {},
                      style: ColorRev.buttonStyle3,
                    ),
                  ],
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
      backgroundColor: ColorRev.g3,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 36, vertical: 0),
            child: Text(
              '문제 기록',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
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
                  itemCount: Results.resultList.length,
                  itemBuilder: (context, index) {
                    int itemCount = Results.resultList.length;
                    if (itemCount > 0) return _buildResult(index);
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
                )),
          ),
          SizedBox(height: 16,)
        ],
      ),
    );
  }
}

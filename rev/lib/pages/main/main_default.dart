import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rev/repository/default_board.dart';
import 'package:rev/repository/test_results.dart';
import 'package:rev/util/color_rev.dart';

import '../../dio_server.dart';

class MainDefault extends StatefulWidget {

  @override
  _MainDefaultState createState() => _MainDefaultState();
}

class _MainDefaultState extends State<MainDefault> {
  Widget _buildResult(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(
                          Boards.boardSummary[index]['title']
                              .toString(),
                          // maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(width: 28,),
                      Text(
                        '${Boards.boardSummary[index]['hits'].toString()} hits',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        Boards.boardSummary[index]['postDate'].toString(),
                        style: TextStyle(fontSize: 10),
                      ),
                      SizedBox(width: 55,),
                      Text(
                        Boards.boardSummary[index]['nickname'],
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ],
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
    );
  }

  @override
  Widget build(BuildContext context) {
    server.getReq('getPinedBoard');
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
        // TextButton(onPressed: () {server.getReq('getPinedBoard');}, child: Text('hi')),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.8,
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32)),
            elevation: 7,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.3,
                  child: ListView.builder(
                    itemCount: Boards.boardSummary.length,
                    itemBuilder: (context, index) {
                      int itemCount = 4;
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
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height*0.3,
                  child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      int itemCount = 4;
                      if (itemCount > 0) return Text('hi');
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
              ],
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

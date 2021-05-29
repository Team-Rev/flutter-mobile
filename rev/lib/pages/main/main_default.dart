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
  ScrollController _scrollController = new ScrollController();
  bool isPerformingRequest = false;
  int currentPage=0;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  _getMoreData() async {
    if (!isPerformingRequest) {
      setState(() => isPerformingRequest = true);
      List<dynamic> newEntries = await req(); //returns empty list
      if (newEntries.isEmpty) {
        double edge = 50.0;
        double offsetFromBottom = _scrollController.position.maxScrollExtent - _scrollController.position.pixels;
        if (offsetFromBottom < edge) {
          _scrollController.animateTo(
              _scrollController.offset - (edge -offsetFromBottom),
              duration: new Duration(milliseconds: 500),
              curve: Curves.easeOut);
        }
      }
      setState(() {
        Boards.boardPage.addAll(newEntries);
        currentPage++;
        isPerformingRequest = false;
      });
    }
  }

  /// from - inclusive, to - exclusive
  Future<dynamic> req() async {
    return Future.delayed(Duration(seconds: 2), () {
      return server.getReq('getNextBoard',page: currentPage);
    });
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isPerformingRequest ? 1.0 : 0.0,
          child: new CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(ColorRev.g3),),
        ),
      ),
    );
  }


  Widget _buildPinedBoard(int index) {
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
                          Boards.boardPined[index]['title']
                              .toString(),
                          // maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(width: 28,),
                      Text(
                        '${Boards.boardPined[index]['hits'].toString()} hits',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        Boards.boardPined[index]['postDate'].toString(),
                        style: TextStyle(fontSize: 10),
                      ),
                      SizedBox(width: 55,),
                      Text(
                        Boards.boardPined[index]['nickname'],
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
  Widget _buildBoardPage(int index) {
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
                          Boards.boardPage[index]['title']
                              .toString(),
                          // maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(width: 28,),
                      Text(
                        '${Boards.boardPage[index]['hits'].toString()} hits',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        Boards.boardPage[index]['postDate'].toString(),
                        style: TextStyle(fontSize: 10),
                      ),
                      SizedBox(width: 55,),
                      Text(
                        Boards.boardPage[index]['nickname'],
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
    // server.getReq('getPinedBoard');
    // server.getReq('getNextBoard',page: currentPage);
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
            '공 지 사 항',
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
                    itemCount: Boards.boardPined.length,
                    itemBuilder: (context, index) {
                      int itemCount = Boards.boardPined.length;
                      if (itemCount > 0) return _buildPinedBoard(index);
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
                  height: MediaQuery.of(context).size.height*0.4,
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: Boards.boardPage.length+1,
                    itemBuilder: (context, index) {
                      int itemCount = Boards.boardPage.length;
                      if(index==Boards.boardPage.length) return _buildProgressIndicator();
                      if (itemCount > 0) return _buildBoardPage(index);
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

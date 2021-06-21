import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rev/repository/default_ask.dart';
import 'package:rev/repository/default_board.dart';
import 'package:rev/repository/test_results.dart';
import 'package:rev/util/color_rev.dart';

import '../../../dio_server.dart';
import 'ask_list.dart';

class DefaultAskDetail extends StatefulWidget {

  @override
  _DefaultAskDetailState createState() => _DefaultAskDetailState();
}

class _DefaultAskDetailState extends State<DefaultAskDetail> {
  ScrollController _scrollController = new ScrollController();
  bool isPerformingRequest = false;
  int currentPage=1;
  int boardNum;
  bool isPined;
  int maxPage;
  //TODO CommentDetail 작성 필요. 지금은 번들만 가져온 상태임.
  // _DefaultAskDetailState(int boardNum, bool isPined) {
  //   this.boardNum = boardNum;
  //   this.isPined = isPined;
  //   print('boardnum $boardNum');
  //   maxPage = isPined ? Boards.boardPined.length : Boards.boardPage.length;
  // }
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
        Ask.askList.addAll(newEntries);
        currentPage++;
        isPerformingRequest = false;
      });
    }
  }

  /// from - inclusive, to - exclusive
  Future<dynamic> req() async {
    return Future.delayed(Duration(seconds: 2), () {
      return server.getReqToQuery(context,'getAskList',page: currentPage);
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
  Widget _buildAskList(int index) {
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
                          Ask.askList[index]['title']
                              .toString(),
                          // maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(width: 28,),
                      Text(
                        '${Ask.askList[index]['hits'].toString()} hits',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        Ask.askList[index]['postDate'].toString(),
                        style: TextStyle(fontSize: 10),
                      ),
                      SizedBox(width: 55,),
                      Text(
                        Ask.askList[index]['nickname'],
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),
              TextButton(
                child: Icon(Icons.arrow_forward_ios),
                onPressed: () {server.getReqToQuery(context, 'getBoardDetail',boardNum: index,isPined: false);},
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorRev.g3,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text(
                  isPined
                      ? Boards.boardPined[boardNum]['title'].toString()
                      : Boards.boardPage[boardNum]['title'].toString(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                isPined
                    ? Boards.boardPined[boardNum]['nickname'].toString()
                    : Boards.boardPage[boardNum]['nickname'].toString(),
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isPined
                    ? Boards.boardPined[boardNum]['postDate'].toString()
                    : Boards.boardPage[boardNum]['postDate'].toString(),
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                isPined
                    ? Boards.boardPined[boardNum]['hits'].toString()
                    : Boards.boardPage[boardNum]['hits'].toString(),
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.8,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              elevation: 7,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      isPined
                          ? Boards.boardPined[boardNum]['detail'].toString()
                          : Boards.boardPage[boardNum]['detail'].toString(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    if (boardNum-1 >= 0) {
                      server.getReqToQuery(context, 'getBoardDetail',
                          boardNum: boardNum - 1, isPined: isPined);
                    }
                  },
                  child: Text('이전'),
                  style: ColorRev.buttonStyle4,
                ),
                TextButton(
                  onPressed: () {
                    // Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DefaultAsk()));
                  },
                  child: Text('목록'),
                  style: ColorRev.buttonStyle4,
                ),
                TextButton(
                  onPressed: () {
                    if (boardNum+1 < maxPage) {
                      server.getReqToQuery(context, 'getBoardDetail',
                          boardNum: boardNum + 1, isPined: isPined);
                    }
                  },
                  child: Text('다음'),
                  style: ColorRev.buttonStyle4,
                ),
              ],
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
                    height: MediaQuery.of(context).size.height*0.79,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: Ask.askList.length+1,
                      itemBuilder: (context, index) {
                        int itemCount = Ask.askList.length;
                        if(index==Ask.askList.length) return _buildProgressIndicator();
                        if (itemCount > 0) return _buildAskList(index);
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

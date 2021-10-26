import 'package:flutter/material.dart';
import 'package:flutter_new/constraints.dart';
import 'package:flutter_new/repo/boards.dart';
import 'package:provider/provider.dart';

import '../../../../server.dart';
import 'notice_detail.dart';

class ShowNotice extends StatefulWidget {
  @override
  _ShowNoticeState createState() => _ShowNoticeState();
}

class _ShowNoticeState extends State<ShowNotice> {
  ScrollController _scrollController = new ScrollController();
  bool isPerformingRequest = false;
  int currentPage = 0;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
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
        double offsetFromBottom = _scrollController.position.maxScrollExtent -
            _scrollController.position.pixels;
        if (offsetFromBottom < edge) {
          _scrollController.animateTo(
              _scrollController.offset - (edge - offsetFromBottom),
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
      return server.getReq('getNextBoard', page: currentPage);
    });
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isPerformingRequest ? 1.0 : 0.0,
          child: new CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(int index) {
    if (index < Boards.boardPined.length)
      return _buildPinedBoard(index);
    else
      return _buildBoardPage(index - Boards.boardPined.length);
  }

  Widget _buildPinedBoard(int index) {
    return Consumer<BoardProvider>(
      builder: (context, provider, child) {
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
                              Boards.boardPined[index]['title'].toString(),
                              // maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                          ),
                          SizedBox(
                            width: 28,
                          ),
                          Text(
                            '${Boards.boardPined[index]['hits'].toString()} hits',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            Boards.boardPined[index]['postDate'].toString(),
                            style: TextStyle(fontSize: 10, color: Colors.red),
                          ),
                          SizedBox(
                            width: 55,
                          ),
                          Text(
                            Boards.boardPined[index]['nickname'],
                            style: TextStyle(fontSize: 10, color: Colors.red),
                          ),
                        ],
                      ),
                    ],
                  ),
                  buildPrimaryTextOnlyButton(
                    context,
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.red,
                    ),
                    () {
                      provider.updatePage(index, true);
                      server.getReq('getBoardDetail',
                          boardNum: index, isPined: true, context: context);
                      Future.delayed(Duration(seconds: 1),() {
                        return Navigator.push(context,MaterialPageRoute(builder: (context)=>NoticeDetail()));
                      });
                    },
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
      },
    );
  }

  Widget _buildBoardPage(int index) {
    return Consumer<BoardProvider>(
      builder: (context, provider, child) {
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
                              Boards.boardPage[index]['title'].toString(),
                              // maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: 28,
                          ),
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
                          SizedBox(
                            width: 55,
                          ),
                          Text(
                            Boards.boardPage[index]['nickname'],
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                  buildPrimaryTextOnlyButton(context, Icon(Icons.arrow_forward_ios),
                          () {
                        provider.updatePage(index, false);
                        server.getReq('getBoardDetail',
                            boardNum: index, isPined: false, context: context);
                        Future.delayed(Duration(seconds: 1),() {
                          return Navigator.push(context,MaterialPageRoute(builder: (context)=>NoticeDetail()));
                        });
                      }),
                  // TextButton(
                  //   child: Icon(Icons.arrow_forward_ios),
                  //   onPressed: () {
                  //     server.getReqToQuery(context, 'getBoardDetail',
                  //         boardNum: index, isPined: false);
                  //   },
                  //   style: ColorRev.buttonStyle3,
                  // ),
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // server.getReq('getPinedBoard');
    // server.getReq('getNextBoard',page: currentPage);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryColor,
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
                  // Container(
                  //   height: MediaQuery.of(context).size.height*0.3,
                  //   child: ListView.builder(
                  //     itemCount: Boards.boardPined.length,
                  //     itemBuilder: (context, index) {
                  //       int itemCount = Boards.boardPined.length;
                  //       if (itemCount > 0) return _buildPinedBoard(index);
                  //       return Center(
                  //         child: Text(
                  //           '기록이 없습니다.',
                  //           style: TextStyle(
                  //               fontSize: 24,
                  //               color: Colors.grey,
                  //               fontWeight: FontWeight.bold),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                  // Container(
                  //   height: MediaQuery.of(context).size.height*0.4,
                  //   child: ListView.builder(
                  //     controller: _scrollController,
                  //     itemCount: Boards.boardPage.length+1,
                  //     itemBuilder: (context, index) {
                  //       int itemCount = Boards.boardPage.length;
                  //       if(index==Boards.boardPage.length) return _buildProgressIndicator();
                  //       if (itemCount > 0) return _buildBoardPage(index);
                  //       return Center(
                  //         child: Text(
                  //           '기록이 없습니다.',
                  //           style: TextStyle(
                  //               fontSize: 24,
                  //               color: Colors.grey,
                  //               fontWeight: FontWeight.bold),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.79,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: Boards.boardPage.length +
                          Boards.boardPined.length +
                          1,
                      itemBuilder: (context, index) {
                        int itemCount =
                            Boards.boardPage.length + Boards.boardPined.length;
                        if (index ==
                            Boards.boardPage.length + Boards.boardPined.length)
                          return _buildProgressIndicator();
                        if (itemCount > 0) return _buildContent(index);
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

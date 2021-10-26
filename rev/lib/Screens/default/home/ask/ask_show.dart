import 'package:flutter/material.dart';
import 'package:flutter_new/Screens/default/home/ask/ask_create_detail.dart';
import 'package:flutter_new/repo/ask.dart';
import 'package:provider/provider.dart';

import '../../../../constraints.dart';
import '../../../../server.dart';
import 'ask_detail.dart';

class ShowAsk extends StatefulWidget {
  @override
  _ShowAskState createState() => _ShowAskState();
}

class _ShowAskState extends State<ShowAsk> {
  ScrollController _scrollController = new ScrollController();
  bool isPerformingRequest = false;
  int currentPage = 1;

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
        Ask.askList.addAll(newEntries);
        currentPage++;
        isPerformingRequest = false;
      });
    }
  }

  /// from - inclusive, to - exclusive
  Future<dynamic> req() async {
    return Future.delayed(Duration(seconds: 2), () {
      return server.getReq('getAskList',page: currentPage);
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

  Widget _buildAskList(int index) {
    return Consumer<AskProvider>(
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
                              Ask.askList[index]['title'].toString(),
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
                          SizedBox(
                            width: 55,
                          ),
                          Text(
                            Ask.askList[index]['nickname'],
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                  buildPrimaryTextOnlyButton(context, Icon(Icons.arrow_forward_ios),
                          () {
                        provider.updatePage(index);
                        server.getReq('gotoAskComment',askId: Ask.askList[index]['askId'], page: 0, context: context);
                        // Future.delayed(Duration(seconds: 2),() {
                        //   return Navigator.push(context,MaterialPageRoute(builder: (context)=>AskDetail()));
                        // });
                      }),
                  // TextButton(
                  //   child: Icon(Icons.arrow_forward_ios),
                  //   onPressed: () {
                  //     // server.getReq('getAskComment', askNum: index, page: 0);
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '질문게시판',
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                buildSecondaryTextOnlyButton(context, Icon(Icons.add), () {Navigator.push(context, MaterialPageRoute(builder: (context) =>CreateAskDetail()));})
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
                    height: MediaQuery.of(context).size.height * 0.79,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: Ask.askList.length + 1,
                      itemBuilder: (context, index) {
                        int itemCount = Ask.askList.length;
                        if (index == Ask.askList.length)
                          return _buildProgressIndicator();
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

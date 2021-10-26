import 'package:flutter/material.dart';
import 'package:flutter_new/repo/ask.dart';
import 'package:provider/provider.dart';

import '../../../../constraints.dart';
import '../../../../secret.dart';
import '../../../../server.dart';

class AskDetail extends StatefulWidget {
  @override
  _AskDetailState createState() => _AskDetailState();
}

class _AskDetailState extends State<AskDetail> {
  ScrollController _scrollController = new ScrollController();
  ScrollController _contentScrollController = ScrollController();
  final keyRefresh = GlobalKey<RefreshIndicatorState>();
  bool isPerformingRequest = false;
  int currentPage = 0;
  int askId = -1;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // getInitData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  // Future getInitData() async {
  //   Future.delayed(Duration(seconds: 2), () {
  //     server.getReq('getAskComment',
  //         askId: Ask.askList[context.read<AskProvider>().askNum]['askId'],
  //         page: 0);
  //   });
  // }

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
        Ask.askComment[askId].addAll(newEntries);
        currentPage++;
        isPerformingRequest = false;
      });
    }
  }

  Future refresh() async {
    // keyRefresh.currentState.show();
    if (!isPerformingRequest) {
      isPerformingRequest = true;
      // setState(() => isPerformingRequest = true);
      currentPage = 0;
      List<dynamic> newEntries = await req();
      setState(() {
        Ask.askComment[askId].clear();
        Ask.askComment[askId].addAll(newEntries);
        currentPage++;
        // Ask.refreshComment(askId);
        isPerformingRequest = false;
      });
    }
  }

  /// from - inclusive, to - exclusive
  Future<dynamic> req() async {
    return Future.delayed(Duration(seconds: 2), () {
      return server.getReq('getAskComment',
          askId: askId, page: currentPage, function: () {});
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

  Widget _buildAskComment(int index) {
    return Consumer<AskProvider>(
      builder: (context, provider, child) {
        return Card(
          elevation: 7,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 200,
                      child: Text(
                        Ask.askComment[Ask.askList[provider.askNum]['askId']]
                                [index]['nickname']
                            .toString(),
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
                      '${Ask.askComment[Ask.askList[provider.askNum]['askId']][index]['postDate'].toString()}',
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: Text(
                            Ask.askComment[Ask.askList[provider.askNum]
                                    ['askId']][index]['comment']
                                .toString(),
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Container(
                          child: Ask.askComment[Ask.askList[provider.askNum]
                                      ['askId']][index]['userId'] ==
                                  Secret.getSub
                              ? buildPrimaryTextOnlyButton(
                                  context, Icon(Icons.close), () {
                                  server.getReq('removeAskComment',
                                      refAsk: Ask.askComment[
                                          Ask.askList[provider.askNum]
                                              ['askId']][index]['refAsk'],
                                      commentId: Ask.askComment[
                                          Ask.askList[provider.askNum]
                                              ['askId']][index]['commentId'],
                                      function: refresh());
                                  // refresh();
                                })
                              : null,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _commentController = TextEditingController();
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final keyRefresh = GlobalKey<RefreshIndicatorState>();

    return Consumer<AskProvider>(
      builder: (context, provider, child) {
        askId = Ask.askList[provider.askNum]['askId'];
        return Scaffold(
          // resizeToAvoidBottomInset: false,
          backgroundColor: primaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.end,
              // crossAxisAlignment: CrossAxisAlignment.start,
              physics: BouncingScrollPhysics(),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        Ask.askList[provider.askNum]['title'].toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      Ask.askList[provider.askNum]['nickname'].toString(),
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
                      Ask.askList[provider.askNum]['postDate'].toString(),
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${Ask.askList[provider.askNum]['hits'].toString()} hits',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                    elevation: 7,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.23,
                          child: Scrollbar(
                            controller: _contentScrollController,
                            // thickness: 10,
                            child: ListView(
                              controller: _contentScrollController,
                              children: [
                                Text(
                                  Ask.askList[provider.askNum]['content']
                                      .toString(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.symmetric(horizontal: 32),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Ask.askList[provider.askNum]['userId'] ==
                                        Secret.getSub
                                    ? buildTextButton(context, Text('글 삭제'),
                                        () {
                                        server.getReq('removeAsk',
                                            askId: Ask.askList[provider.askNum]
                                                ['askId']);
                                      })
                                    : SizedBox(),
                                SizedBox(
                                  width: 16,
                                ),
                                buildTextButton(
                                    context,
                                    Text(
                                        '${Ask.askList[provider.askNum]['recommend'].toString()} ❤'),
                                    () {
                                  setState(() {
                                    Ask.askList[provider.askNum]['recommend']++;
                                    //recommend 추가하는 로직 구성 요망
                                  });
                                }),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '댓  글',
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            buildSelectTextButton(
                                context, Icon(Icons.wifi_protected_setup_sharp),
                                () {
                              refresh();
                            })
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: RefreshIndicator(
                          key: keyRefresh,
                          onRefresh: refresh,
                          child: ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            controller: _scrollController,
                            itemCount: Ask
                                    .askComment[Ask.askList[provider.askNum]
                                        ['askId']]
                                    .length +
                                1,
                            itemBuilder: (context, index) {
                              // keyRefresh.currentState.show();
                              int itemCount = Ask
                                  .askComment[Ask.askList[provider.askNum]
                                      ['askId']]
                                  .length;
                              if (index ==
                                  Ask
                                      .askComment[Ask.askList[provider.askNum]
                                          ['askId']]
                                      .length) return _buildProgressIndicator();
                              if (itemCount > 0) return _buildAskComment(index);
                              return Center(
                                child: Text(
                                  '댓글이 없습니다.',
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
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildSecondaryTextOnlyButton(
                        context,
                        Text('이전'),
                        () {
                          if (provider.askNum - 1 >= 0) {
                            server.getReq('getAskComment',
                                askId: Ask.askList[provider.askNum - 1]
                                    ['askId'],
                                page: 0,
                                function: provider.previousPage);

                            // Future.delayed(Duration(seconds: 1), () {
                            //   return provider.previousPage();
                            // });
                          }
                        },
                      ),
                      buildSecondaryTextOnlyButton(
                        context,
                        Text('목록'),
                        () {
                          Navigator.pop(context);
                        },
                      ),
                      buildSecondaryTextOnlyButton(
                        context,
                        Text('다음'),
                        () {
                          if (provider.askNum + 1 < provider.maxPage) {
                            server.getReq('getAskComment',
                                askId: Ask.askList[provider.askNum + 1]
                                    ['askId'],
                                page: 0,
                                function: provider.nextPage);
                            // Future.delayed(Duration(seconds: 1), () {
                            //   return provider.nextPage();
                            // });
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Form(
                          key: _formKey,
                          child: buildTextFormField(
                              context, _commentController, null, '댓글을 입력하세요',
                              validator: primaryValidator),
                        ),
                      ),
                      buildTextButton(context, Text('제출'), () {
                        server.getReq('addAskComment',
                            askComment: _commentController.text,
                            refAsk: Ask.askList[provider.askNum]['askId']);
                        refresh();
                      })
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

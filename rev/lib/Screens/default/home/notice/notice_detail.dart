import 'package:flutter/material.dart';
import 'package:flutter_new/constraints.dart' as notice_detail;
import 'package:flutter_new/repo/boards.dart';
import 'package:provider/provider.dart';

import '../../../../server.dart';

// class NoticeDetail extends StatefulWidget {
//
//   @override
//   _NoticeDetailState createState() => _NoticeDetailState();
// }

class NoticeDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<BoardProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: notice_detail.primaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        provider.isPined
                            ? Boards.boardPined[provider.boardNum]['title']
                                .toString()
                            : Boards.boardPage[provider.boardNum]['title']
                                .toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      provider.isPined
                          ? Boards.boardPined[provider.boardNum]['nickname']
                              .toString()
                          : Boards.boardPage[provider.boardNum]['nickname']
                              .toString(),
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
                      provider.isPined
                          ? Boards.boardPined[provider.boardNum]['postDate']
                              .toString()
                          : Boards.boardPage[provider.boardNum]['postDate']
                              .toString(),
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      provider.isPined
                          ? Boards.boardPined[provider.boardNum]['hits']
                              .toString()
                          : Boards.boardPage[provider.boardNum]['hits']
                              .toString(),
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
                            provider.isPined
                                ? Boards.boardPined[provider.boardNum]['detail']
                                    .toString()
                                : Boards.boardPage[provider.boardNum]['detail']
                                    .toString(),
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
                      notice_detail.buildSecondaryTextOnlyButton(
                        context,
                        Text('이전'),
                        () {
                          if (provider.boardNum - 1 >= 0) {
                            server.getReq('getBoardDetail',
                                boardNum: provider.boardNum - 1,
                                isPined: provider.isPined,
                                context: context);

                            Future.delayed(Duration(seconds: 1), () {
                              return provider.previousPage();
                            });
                          }
                        },
                      ),
                      notice_detail.buildSecondaryTextOnlyButton(
                        context,
                        Text('목록'),
                        () {
                          Navigator.pop(context);
                        },
                      ),
                      notice_detail.buildSecondaryTextOnlyButton(
                        context,
                        Text('다음'),
                        () {
                          if (provider.boardNum + 1 < provider.maxPage) {
                            server.getReq('getBoardDetail',
                                boardNum: provider.boardNum + 1,
                                isPined: provider.isPined,
                                context: context);
                            Future.delayed(Duration(seconds: 1), () {
                              return provider.nextPage();
                            });
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

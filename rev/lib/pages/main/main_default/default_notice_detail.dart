import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rev/pages/main/main_default/default_notice.dart';
import 'package:rev/pages/main/main_default/main_default.dart';
import 'package:rev/repository/default_board.dart';
import 'package:rev/util/color_rev.dart';

import '../../../dio_server.dart';


class DefaultNoticeDetail extends StatelessWidget {
  int boardNum;
  bool isPined;
  int maxPage;

  DefaultNoticeDetail(int boardNum, bool isPined) {
    this.boardNum = boardNum;
    this.isPined = isPined;
    print('boardnum $boardNum');
    maxPage = isPined ? Boards.boardPined.length : Boards.boardPage.length;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorRev.g3,
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MainDefault()));
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
            )
          ],
        ),
      ),
    );
  }
}

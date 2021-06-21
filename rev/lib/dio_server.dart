import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rev/pages/auth/auth_login.dart';
import 'package:rev/pages/main/main_ask/ask_list.dart';
import 'package:rev/pages/main/main_default/default_notice_detail.dart';
import 'package:rev/pages/main/main_page.dart';
import 'package:rev/pages/main/main_test/test_question.dart';
import 'package:rev/pages/main/main_test/test_showresult.dart';
import 'package:rev/pages/main/main_test/test_showresult_detail.dart';
import 'package:rev/repository/default_ask.dart';
import 'package:rev/repository/default_board.dart';
import 'package:rev/repository/test_questions.dart';
import 'package:rev/repository/test_results.dart';
import 'package:rev/secret.dart';
import 'package:rev/util/color_rev.dart';
import 'package:rev/util/reusable.dart';

//http형식으로 데이터 요청

class Server {
  //Future란? 정리해서 올리기
  Future<dynamic> getReq(String type,{page}) async {
    //Response : Dio에서 가져와서 사용. Data 반환
    Response response;
    // var options =
    //     BaseOptions(headers: {'Authorization': 'Bearer ${Secret.token}'});
    Dio dio = Dio();
    String addr;
    switch(type) {
      case 'getPinedBoard':
        addr='board/notice-pined';
        break;
      case 'getNextBoard':
        addr='board/notice?page=$page';
        break;
      case 'getPinedBoardAndPage':
        addr='board/notice-first?page=0';
        break;
    }
    //DogetRequest
    response = await dio.get(
      "${Secret.path}$addr",
    );

    switch(type) {
      case 'getPinedBoard':
        Boards.initBoardsPined(response.data);
        break;
      case 'getNextBoard':
        // Boards.initBoardsPage(response.data);
        return response.data['notices'];
        break;
      case 'getPinedBoardAndPage':
        Boards.initBoardsPined(response.data['pined']);
        Boards.initBoardsPage(response.data['page']['notices']);
        break;
    }
  }

  void doPost(BuildContext context, String type,
      {username,
      password,
      userId,
      nickname,
      name,
      DOB,
      phone,
      address,
      detailAddress,
      postNumber}) {
    Map<String, dynamic> data;
    String addr = '';
    List<Map<String, dynamic>> submitList = [];
    switch (type) {
      case 'authenticate':
        addr = 'authenticate';
        data = {"username": username, "password": password};

        // getReq('getPinedBoard');
        // getReq('getNextBoard',page: 0);
        getReq('getPinedBoardAndPage');
        Future.delayed(Duration(seconds: 2,),() {
          return postReq(context, type, data, addr);
          // getReq('getNextBoard',page: 0);
        } );
        break;

      case 'signup':
        addr = 'signup';
        data = {
          "userId": userId,
          "password": password,
          "nickname": nickname,
          "name": name,
          "DOB": DOB,
          "phone": phone,
          "address": address,
          "detailAddress": detailAddress,
          "postNumber": postNumber
        };
        postReq(context, type, data, addr);
        break;

      case 'submit':
        addr = 'problem/submit';
        var options =
            BaseOptions(headers: {'Authorization': 'Bearer ${Secret.token}'});
        submitList.clear();

        for (int i = 0; i < Questions.submitList.length; i++) {
          submitList.add({
            'questionId': Questions.questionNumList[i],
            'multipleChoiceIds': Questions.submitList[i]
          });
        }
        data = {
          'userId': Secret.getSub,
          'submitList': submitList,
        };
        postReq(context, type, data, addr, options: options);
        break;
    }
    // postReq(context, type, data, addr, options: options);
  }

  //DoPost
  Future<dynamic> postReq(BuildContext context, String type, data, String addr,
      {options}) async {
    Response response;
    Dio dio = Dio(options);
    print('hi');
    //DoPostRequest
    print('${Secret.path}$addr');
    response = await dio.post('${Secret.path}$addr', data: data);
    print("result" + response.data.toString());

    if (response.data.toString() == null) return false;
    switch (type) {
      case 'authenticate':
        //TODO Success, Fail 판별해서 팝업 띄우기 추가
        Secret.setToken(response.data['jwt']);

        // server.getReq('getPinedBoard');
        // server.getReq('getNextBoard',page: 0);

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainWidget()));
        // gotomain
        break;
      case 'signup':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AuthLogin()));
        //TODO Success, Fail 판별해서 팝업 띄우기 추가
        break;
      case 'submit':
        Questions.initQuestionResult(response.data);
        return showDialog<void>(
            context: context,
            // barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)),
                title: Center(
                    child: Text(
                  '시험 결과',
                  style: TextStyle(
                    color: ColorRev.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                contentPadding: EdgeInsets.fromLTRB(24, 12, 24, 0),
                content: Container(
                  height: 100,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                    elevation: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${Questions.questionResult['totalCount']}개의 문제 중',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${Questions.questionResult['correctCount']}개를 맞췄습니다 !',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                elevation: 7,
                backgroundColor: ColorRev.g3,
                actionsPadding: EdgeInsets.symmetric(horizontal: 64),
                actionsOverflowButtonSpacing: 100,
                actions: [
                  SizedBox(
                    width: 72,
                    child: ReUsable.buildTextButton(
                      '상세보기',
                      Colors.transparent,
                      ColorRev.white,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    width: 72,
                    child: ReUsable.buildTextButton(
                      '목록으로',
                      Colors.transparent,
                      ColorRev.white,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainWidget()));
                      },
                    ),
                  ),
                ],
              );
            });
        break;
    }
    return true;
  }

//getRequestWithQuery
  Future<dynamic> getReqToQuery(
    BuildContext context,
    String type, {
    int start,
    int end,
        int page,
        int answerMainId,
        int boardNum,
        bool isPined,
  }) async {
    Response response;
    var options =
        BaseOptions(headers: {'Authorization': 'Bearer ${Secret.token}'});
    Dio dio = Dio(options);
    Map<String, dynamic> queryParameters;
    String addr;
    switch (type) {
      case 'getQuestionByRange':
        addr = 'problem/rangeQuestions';
        queryParameters = {
          'start': start,
          'end': end,
        };
        break;
      case 'getResults':
        addr = 'problem/answer/summary';
        queryParameters = {'id': Secret.getSub, 'page': 0};
        break;
      case 'getResults2':
        addr = 'problem/answer/summary';
        queryParameters = {'id': Secret.getSub, 'page': page};
        break;
      case 'getResultQuestions':
        addr = 'problem/answer/detail';
        queryParameters = {'id': answerMainId};
        break;
      case 'getBoardDetail':
        addr='board/notice-content';
        queryParameters={'id':isPined ? Boards.boardPined[boardNum]['noticeId']:Boards.boardPage[boardNum]['noticeId']};
        break;
      case 'getAskList':
        addr='board/ask';
        queryParameters={'page': page};
    }

    response =
        await dio.get('${Secret.path}$addr', queryParameters: queryParameters);
    print(response.data);

    switch (type) {
      case 'getQuestionByRange':
        print(response.data.toString());
        Questions.init(response.data);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => TestQuestion()));
        break;
      case 'getResults':
        Results.initResultSummary(response.data);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ShowResult()));
        break;
      case 'getResults2':
        return response.data;

        break;
      case 'getResultQuestions':
        Results.initResultQuestions(response.data);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ResultDetail()));
        break;
      case 'getBoardDetail':
        if(isPined)
              Boards.boardPined[boardNum].putIfAbsent('detail',() =>response.data);
        else
              Boards.boardPage[boardNum].putIfAbsent('detail',() =>response.data);

        Navigator.push(context,MaterialPageRoute(builder: (context)=>DefaultNoticeDetail(boardNum,isPined)));
        break;
      case 'getAskList':
        if(page==0) {
          if(Ask.askList.length==0) {
            Ask.initAskList(response.data['asks']['content']);
            print('initAskList complete!');
          }
          Navigator.push(context, MaterialPageRoute(builder: (context) => DefaultAsk()));
        }
        else {
          return response.data['asks']['content'];
        }




    }
  }
}

Server server = Server();

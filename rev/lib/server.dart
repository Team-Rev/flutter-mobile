import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/Screens/auth/auth_changepw.dart';
import 'package:flutter_new/Screens/default/home/ask/ask_show.dart';
import 'package:flutter_new/Screens/default/profile/profile_edit.dart';
import 'package:flutter_new/Screens/default/profile/profile_pointlist.dart';
import 'package:flutter_new/constraints.dart';
import 'package:flutter_new/main.dart';
import 'package:flutter_new/repo/ask.dart';
import 'package:flutter_new/repo/boards.dart';
import 'package:flutter_new/repo/problems.dart';
import 'package:flutter_new/secret.dart';
import 'package:provider/provider.dart';

import 'Screens/default/default.dart';
import 'Screens/default/home/ask/ask_detail.dart';
import 'Screens/default/study/result_detail.dart';
import 'Screens/default/study/study_problem.dart';

class Server {
  Dio dio;
  BaseOptions options;

  dynamic getReq(String type,
      {username,
      password,
      userId,
      nickname,
      name,
      DOB,
      phone,
      address,
      detailAddress,
      postNumber,
      context,
      start,
      end,
      page,
      answerMainId,
      isPined,
      boardNum,
      askNum,
      askId,
      askComment,
      refAsk,
      commentId, function, title, content}) async {
    String addr, reqType;
    Map<String, dynamic> data;
    List<Map<String, dynamic>> submitList = [];
    Map<String, dynamic> queryParameters;

    //선택지 구분
    switch (type) {
//---------------------------------------------------------------------------------------------
//    Auth Part
//---------------------------------------------------------------------------------------------
      case 'authenticate': //로그인
        reqType = 'post';
        addr = 'authenticate';
        data = {"userId": userId, "password": password};
        break;

      case 'signup': //회원가입
        reqType = 'post';
        addr = 'auth/signup';
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
        break;

      case 'findID': //아이디 찾기
        reqType = 'post';
        addr = 'auth/findId';
        data = {
          'name': name,
          'phone': phone,
        };
        break;

      case 'findPW': //비밀번호 찾기
        reqType = 'post';
        addr = 'auth/findPw';
        data = {
          'userId': userId,
          'name': name,
          'phone': phone,
        };
        break;

      case 'changePW': //비밀번호 바꾸기
        reqType = 'patch';
        addr = 'auth/updatePw';
        data = {"userId": userId, "newPassword": password};
        break;

//---------------------------------------------------------------------------------------------
//    Board Part
//---------------------------------------------------------------------------------------------

      case 'getPinedBoard': //고정 공지사항 가져오기
        reqType = 'get';
        addr = 'board/notice-pined';
        break;

      case 'getNextBoard': //다음 공지사항 페이지 가져오기
        reqType = 'get';
        addr = 'board/notice?page=$page';
        break;

      case 'getBoardDetail': //공지사항 세부사항 가져오기
        reqType = 'get';
        addr = 'board/notice-content';
        queryParameters = {
          'id': isPined
              ? Boards.boardPined[boardNum]['noticeId']
              : Boards.boardPage[boardNum]['noticeId']
        };
        break;

      case 'getPinedBoardAndPage': //첫번쨰 공지사항 받아오기
        reqType = 'get';
        addr = 'board/notice-first?page=0';
        break;

//---------------------------------------------------------------------------------------------
//    Problem Part
//---------------------------------------------------------------------------------------------

      case 'getQuestionByRange': //범위에 따른 문제 받아오기, TODO : 뺄 예정
        reqType = 'get';
        addr = 'problem/rangeQuestions';
        queryParameters = {
          'start': start,
          'end': end,
        };
        break;

      case 'submit':
        reqType = 'post';
        addr = 'problem/submit';
        // var options =
        // BaseOptions(headers: {'Authorization': 'Bearer ${Secret.token}'});
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
        break;

      // case 'getResults':
      //   reqType = 'get';
      //   addr = 'study/answer/summary';
      //   queryParameters = {'id': Secret.getSub, 'page': 0};
      //   break;
      case 'getResults':
        reqType = 'get';
        addr = 'problem/answer/summary';
        queryParameters = {'id': Secret.getSub, 'page': page};
        break;
      case 'getResultQuestions':
        reqType = 'get';
        addr = 'problem/answer/detail';
        queryParameters = {'id': answerMainId};
        break;
//---------------------------------------------------------------------------------------------
//    Ask Part
//---------------------------------------------------------------------------------------------

      case 'gotoAskList':
      case 'getAskList':
        reqType = 'get';
        addr = 'board/ask';
        queryParameters = {'page': page};
        break;
      case 'getAskDetail':
        reqType = 'get';
        addr = 'board/ask/$askNum';
        break;
      case 'gotoAskComment':
      case 'getAskComment':
        reqType = 'get';
        addr = 'board/comment';
        queryParameters = {'askId': askId, 'page': page};
        break;
      case 'addAskComment':
        reqType = 'post';
        addr = 'board/comment';
        data = {
          'userId': Secret.getSub,
          'nickname': Secret.nickname,
          'comment': askComment,
          'refAsk': refAsk
        };
        break;
      case 'removeAskComment':
        reqType = 'delete';
        addr = 'board/comment';
        queryParameters={
          'commentId': commentId,
          'refAsk': refAsk,
          'userId': Secret.getSub
        };
        break;
      case 'createNewAsk':
        reqType='post';
        addr='board/ask';
        data={
          'userId':Secret.getSub,
          'nickname':Secret.nickname,
          'title':title,
          'content':content
        };
        break;
      case 'removeAsk':
        reqType='delete';
        addr='board/ask';
        queryParameters={'askId':askId};
        break;
//---------------------------------------------------------------------------------------------
//    Profile Part
//---------------------------------------------------------------------------------------------
      case 'getProfile':
        reqType='get';
        addr='auth/userInfo';
        queryParameters={'userId':Secret.getSub};
        break;
      case 'getPointList':
        reqType='get';
        addr='point/reasonList';
        break;
    }

    Response response = await _Req(reqType, addr,
        queryParameters: queryParameters, data: data, options: options);
    print(response.data);

    switch (type) {
//---------------------------------------------------------------------------------------------
//    Auth Part
//---------------------------------------------------------------------------------------------
      case 'authenticate': //로그인
        if (response.data == 'Incorrect username or password') {
          //TODO : 틀렸다는 표시 하기
        } else {
          Secret.setToken(response.data['jwt'], response.data['nickname']);
          options =
              BaseOptions(headers: {'Authorization': 'Bearer ${Secret.token}'});
          getReq('getPinedBoardAndPage', context: context);
        }
        break;

      case 'findID': //아이디 찾기
        _buildFailAlert(context,
            widget: Text(
              response.data.toString() == 'USER NOT FOUND'
                  ? '유저를 찾지 못했습니다.'
                  : '요청하신 아이디는 \n${response.data} \n입니다.',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ));
        break;

      case 'findPW': //비밀번호 찾기
        if (response.data == 'OK') {
          //비밀번호 바꾸기 허용
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChangePassword(
                        userId: userId,
                      )));
        } else {
          //TODO : Fail 띄우기
        }
        break;

      case 'signup': //회원가입
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => AuthLogin()));
        //TODO Success, Fail 판별해서 팝업 띄우기 추가
        break;

      case 'changePW': //비밀번호 바꾸기
        print('성공');
        print(response.data);
        _buildFailAlert(context,
            widget: Text(
              response.data.toString() == 'UPDATE SUCCESS'
                  ? '비밀번호가 변경되었습니다. \n변경된 비밀번호로 로그인해주세요.'
                  : '비밀번호 변경에 실패하였습니다.',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ));
        break;

//---------------------------------------------------------------------------------------------
//    Board Part
//---------------------------------------------------------------------------------------------

      case 'getPinedBoard': //고정 공지사항 가져오기
        Boards.initBoardsPined(response.data);
        break;
      case 'getNextBoard': //다음 공지사항 페이지 가져오기
        return response.data['notices'];
        break;
      case 'getPinedBoardAndPage': //첫번쨰 공지사항 받아오기
        Boards.initBoardsPined(response.data['pined']);
        Boards.initBoardsPage(response.data['page']['notices']);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DefaultPage()));
        break;

      case 'getBoardDetail': //공지사항 세부사항 가져오기
        if (isPined)
          Boards.boardPined[boardNum]
              .putIfAbsent('detail', () => response.data);
        else
          Boards.boardPage[boardNum].putIfAbsent('detail', () => response.data);
        break;

//---------------------------------------------------------------------------------------------
//    Problem Part
//---------------------------------------------------------------------------------------------

      case 'getQuestionByRange':
        print(response.data.toString());
        Questions.init(response.data);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => TestQuestion()));
        break;

      case 'submit':
        Questions.initQResult(response.data);
        return _buildAlert(context);
        break;

      //   break;
      // case 'getResults':
      //   Results.initResultSummary(response.data);
      //   Navigator.push(
      //       context, MaterialPageRoute(builder: (context) => ShowResult()));
      //   break;
      case 'getResults':
        if (Results.isEmptySummary()) {
          Results.initResultSummary(response.data);
        }
        return response.data;
        break;
      case 'getResultQuestions':
        Results.initResultQuestions(response.data);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ResultDetail()));
        break;
//---------------------------------------------------------------------------------------------
//    Ask Part
//---------------------------------------------------------------------------------------------
      case 'gotoAskList':
        if (Ask.isAskListEmpty())
          Ask.initAskList(response.data['asks']['content']);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ShowAsk()));
        break;
      case 'getAskList':
        if (Ask.isAskListEmpty())
          Ask.initAskList(response.data['asks']['content']);
        return response.data['asks']['content'];
        break;
      case 'getAskDetail':
        break;
      case 'gotoAskComment':
        if (Ask.isAskCommentEmpty(askId))
          Ask.initAskComment(response.data, askId);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AskDetail()));
        break;

      case 'getAskComment':
        if (Ask.isAskCommentEmpty(askId))
          Ask.initAskComment(response.data, askId);
        function();
        return response.data;
        break;
      case 'addAskComment':
        if (response.data == 'OK') {
          //댓글질 잘 했다고 보내
          print('OK');
        }
        break;

        case 'removeAskComment':
        if (response.data == 'OK') {
          //댓글질 잘 했다고 보내
          print('OK');
          function;
        }
        break;
      case 'createNewAsk':
        print('성공');
        Navigator.pop(context);
        break;
      case 'removeAsk':
        print('성공');
        Navigator.pop(context);
        break;
//---------------------------------------------------------------------------------------------
//    Profile Part
//---------------------------------------------------------------------------------------------
      case 'getProfile':
        Secret.initProfileInfo(response.data);
        Navigator.push(context, MaterialPageRoute(builder: (context) =>ProfileEdit()));
        break;
      case 'getPointList':
        Secret.initPointInfo(response.data);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>PointList()));
        break;
    }
  }

  Future<Response> _Req(String type, String addr,
      {queryParameters, data, options}) async {
    dio = Dio(options);
    Response response;
    switch (type) {
      case 'post':
        response = await dio.post('${Secret.path}$addr', data: data);
        break;
      case 'get':
        response = await dio.get('${Secret.path}$addr',
            queryParameters: queryParameters);
        break;
      case 'patch':
        response = await dio.patch('${Secret.path}$addr', data: data);
        break;
      case 'delete':
        response = await dio.delete('${Secret.path}$addr', queryParameters: queryParameters);
    }
    return response;
  }

  dynamic _buildFailAlert(context, {widget}) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            title: Center(
                child: Text(
              '결    과',
              style: TextStyle(
                color: textPrimaryColor,
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
                    widget,
                  ],
                ),
              ),
            ),
            elevation: 7,
            backgroundColor: primaryColor,
            // actionsPadding: EdgeInsets.symmetric(horizontal: 64),
            // actionsOverflowButtonSpacing: 100,
            actions: [
              SizedBox(
                  width: 72,
                  child: buildTextButton(context, Text('이전'), () {
                    Navigator.of(context).pop();
                  })),
            ],
          );
        });
  }

  dynamic _buildAlert(context) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            title: Center(
                child: Text(
              '시험 결과',
              style: TextStyle(
                color: textPrimaryColor,
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${Questions.questionResult['correctCount']}개를 맞췄습니다 !',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            elevation: 7,
            backgroundColor: primaryColor,
            actionsPadding: EdgeInsets.symmetric(horizontal: 64),
            actionsOverflowButtonSpacing: 100,
            actions: [
              SizedBox(
                width: 72,
                child: buildTextButton(context, Text('상세 보기'), () {}),
              ),
              SizedBox(
                  width: 72,
                  child: buildTextButton(context, Text('목록으로'), () {
                    Navigator.popUntil(context, (route) => false); /*메인으로 돌아가기*/
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (route) => false);
                  })),
            ],
          );
        });
  }
}

Server server = Server();

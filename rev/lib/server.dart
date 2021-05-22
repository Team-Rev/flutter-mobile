import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rev/pages/auth/auth_login.dart';
import 'package:rev/pages/main/main_page.dart';
import 'package:rev/pages/main/main_test/test_question.dart';
import 'package:rev/pages/main/main_test/test_showresult.dart';
import 'package:rev/pages/main/main_test/test_showresult_detail.dart';
import 'package:rev/repository/test_questions.dart';
import 'package:rev/repository/test_results.dart';
import 'package:rev/secret.dart';
import 'package:rev/util/color_rev.dart';
import 'package:rev/util/reusable.dart';

class Server {
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
      answerMainId}) async {
    String addr;
    Map<String, dynamic> data;
    List<Map<String, dynamic>> submitList = [];
    Map<String, dynamic> queryParameters;
    String reqType;
    switch (type) {
      case 'getPinedBoard':
        reqType = 'get';
        addr = 'board/notice-pined';
        break;

      case 'authenticate':
        reqType = 'post';
        addr = 'authenticate';
        data = {"username": username, "password": password};
        break;

      case 'signup':
        reqType = 'post';
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
        break;
      case 'submit':
        reqType = 'post';
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
        break;
      case 'getQuestionByRange':
        reqType = 'get';
        addr = 'problem/rangeQuestions';
        queryParameters = {
          'start': start,
          'end': end,
        };
        break;
      case 'getResults':
        reqType = 'get';
        addr = 'problem/answer/summary';
        queryParameters = {'id': Secret.getSub, 'page': 0};
        break;
      case 'getResults2':
        reqType = 'get';
        addr = 'problem/answer/summary';
        queryParameters = {'id': Secret.getSub, 'page': page};
        break;
      case 'getResultQuestions':
        reqType = 'get';
        addr = 'problem/answer/detail';
        queryParameters = {'id': answerMainId};
        break;
    }
    Response response =
        await _Req(reqType, addr, queryParameters: queryParameters, data: data);

    switch (type) {
      case 'authenticate':
        //TODO Success, Fail 판별해서 팝업 띄우기 추가
        if (response.data == null) return false;

        Secret.setToken(response.data['jwt']);
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
        return _buildAlert(context);
        break;
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
    }
  }

  Future<Response> _Req(String type, String addr,
      {queryParameters, data, options}) async {
    Dio dio = Dio(options);
    Response response;
    switch (type) {
      case 'post':
        response = await dio.post('${Secret.path}$addr', data: data);
        break;
      case 'get':
        response = await dio.get('${Secret.path}$addr',
            queryParameters: queryParameters);
        break;
    }
    return response;
  }

  dynamic _buildAlert(context) {
    return showDialog<void>(
        context: context,
        // barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainWidget()));
                  },
                ),
              ),
            ],
          );
        });
  }
}

Server server=Server();

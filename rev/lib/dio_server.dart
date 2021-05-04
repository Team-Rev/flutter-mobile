import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rev/pages/main/main_page.dart';
import 'package:rev/pages/main/main_test/Test_Question.dart';
import 'package:rev/pages/main/main_test/test_main.dart';
import 'package:rev/provider/questions.dart';
import 'package:rev/secret.dart';

//http형식으로 데이터 요청

class Server {
  //Future란? 정리해서 올리기
  Future<void> getReq() async {
    //Response : Dio에서 가져와서 사용. Data 반환
    Response response;
    var options =
        BaseOptions(headers: {'Authorization': 'Bearer ${Secret.token}'});
    Dio dio = Dio(options);
    //DogetRequest
    response = await dio.get(
      "${Secret.path}problem/rangeQuestions?start=1&end=10",
    );

    print(response.data.toString());
  }

  //DoPost
  Future<dynamic> postReq(BuildContext context, function, String type,
      {username,
      password,
      userId,
      nickname,
      name,
      DOB,
      phone,
      address,
      detailAddress,
      postNumber}) async {
    Response response;
    Map<String, dynamic> data;
    Dio dio = Dio();
    String addr = '';
    List<Map<String, dynamic>> submitList = [];

    switch (type) {
      case 'SignIn':
        addr = 'authenticate';
        data = {"username": username, "password": password};
        break;
      case 'SignUp':
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
          dio.options.headers.addAll(({'Authorization': 'Bearer ${Secret.token}'}));

      submitList.clear();
      for (int i = 0; i < Questions.submitList.length; i++) {
        submitList.add({
          'questionId': Questions.questionNumList[i],
          'multipleChoiceIds': Questions.submitList[i]
        });
      }
      addr = 'problem/submit';
      data = {
        'userId': 'user@naver.com',
        'submitList': submitList,
      };
      break;
    }

    //DoPostRequest
    print('${Secret.path}$addr');
    response = await dio.post('${Secret.path}$addr', data: data);
    print("result" + response.data.toString());
    if (response.data.toString() == null) return false;
    switch (type) {
      case 'SignIn':
        //TODO Success, Fail 판별해서 팝업 띄우기 추가
        Secret.setToken(response.data['jwt']);
        function.goToMain();
        break;
      case 'SignUp':
        //TODO Success, Fail 판별해서 팝업 띄우기 추가
        break;
      case 'FindId':
      case 'FindPw':
      case 'CheckIdValidate':
      case 'submit':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainWidget()));
        break;
    }
    return true;
  }

//getRequestWithQuery
  Future<void> getReqToQuery(
    BuildContext context,
    String type, {
    int start,
    int end,
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
    }
    response =
        await dio.get('${Secret.path}$addr', queryParameters: queryParameters);
    // List<dynamic>data=response.data;
    // print(response.data.toString());
    dynamic question = [];
    question = response.data;

    print(question.toString());
    // Questions.init(Questions.question);
    Questions.init(question);
    // print(response.data.toString());
    switch (type) {
      case 'getQuestionByRange':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => TestQuestion()));
        break;

    }
  }
}

Server server = Server();

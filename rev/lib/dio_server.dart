import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rev/pages/auth/auth_login.dart';
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
        postReq(context, type, data, addr);
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
          'userId': 'user@naver.com',
          'submitList': submitList,
        };
        postReq(context, type, data, addr,options: options);
        break;
    }
    // postReq(context, type, data, addr, options: options);
  }

  //DoPost
  Future<dynamic> postReq(BuildContext context, String type, data,String addr,
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

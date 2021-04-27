import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

//http형식으로 데이터 요청

//접근링크
//3.35.24.199
const _API_Auth = "http://210.101.235.209:8760/";

class Server {
  //Future란? 정리해서 올리기
  Future<void> getReq() async {
    //Response : Dio에서 가져와서 사용. Data 반환
    Response response;
    Dio dio = Dio();
    //DogetRequest
    // response = await dio.get("$_API_PREFIX/1");
    print(response.data.toString());
  }

//authentication용
  Future<dynamic> postReq(String type,{username, password}) async {
    Response response;
    Map<String, dynamic> data;
    Dio dio = Dio();
    String addr='';
    switch(type) {
      case 'SignIn':
        addr='authenticate';
        data={"username": username, "password": password};
        break;
      case 'SignUp':
        addr='signup';
        data={"email": username, "password": password};
        break;
      case 'FindId':
      case 'FindPw':
      case 'CheckIdValidate':
    }
    //DoPostRequest
    response = await dio.post("{$_API_Auth}{$addr}", data: data);
    print("result"+response.data.toString());
    if(response.data.toString()==null)
      return 1;
    return 0;
  }


  // //getRequestWithQuery
  // Future<void> getReqWzQueery() async {
  //   Response response;
  //   Dio dio = Dio();
  //   // response = await dio.get(_API_PREFIX, queryParameters: {
  //   //   "id": 1, //id
  //   //   "pw": 2, //pw
  //   // });
  //   print(response.data.toString());
  // }
}

Server server = Server();

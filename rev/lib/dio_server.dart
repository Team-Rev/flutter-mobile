import 'package:dio/dio.dart';
import 'package:rev/secret.dart';

//http형식으로 데이터 요청

class Server {
  //Future란? 정리해서 올리기
  Future<void> getReq() async {
    //Response : Dio에서 가져와서 사용. Data 반환
    Response response;
    var options=BaseOptions(headers: {
      'Authorization':'Bearer ${Secret.token}'
    });
    Dio dio = Dio(options);
    //DogetRequest
    response = await dio.get("${Secret.path}/problem/rangeQuestions?start=:1&end=:10",);

    print(response.data.toString());
  }

  //DoPost
  Future<dynamic> postReq(function, String type,
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
    switch (type) {
      case 'SignIn':
        addr = 'authenticate';
        data = {"username": username, "password": password};
        break;
      case 'SignUp':
        addr = 'signup';
        data = {"userId": userId,
          "password": password,
          "nickname": nickname,
          "name": name,
          "DOB": DOB,
          "phone": phone,
          "address": address,
          "detailAddress": detailAddress,
          "postNumber": postNumber};
        break;
      case 'FindId':
      case 'FindPw':
      case 'CheckIdValidate':
    }

    //DoPostRequest
    print('${Secret.path}$addr');
    response = await dio.post('${Secret.path}$addr', data: data);
    print("result" + response.data.toString());
    if (response.data.toString() == null) return false;
    switch(type) {
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
    }
    return true;
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
import 'package:dio/dio.dart';
import 'package:rev/secret.dart';

//http형식으로 데이터 요청

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

  //DoPost
  Future<dynamic> postReq(String type,
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
    data = {
      "userId": "test@naver.com",
      "password": "asdf123123",
      "nickname": "상민",
      "name": "이상민",
      "DOB": "1998-11-20",
      "phone": "01034087477",
      "address": "대구광역시 북구 칠곡중앙대로",
      "detailAddress": "전원맨션",
      "postNumber": "41527"
    };
    //DoPostRequest
    // response = await dio.post("{$_API_Auth}{$addr}", data: data);
    print('${Secret.path}$addr');
    response = await dio.post('{$Secret().path}{$addr}', data: data);
    print("result" + response.data.toString());
    if (response.data.toString() == null) return 1;
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

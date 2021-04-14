import 'package:dio/dio.dart';

//http형식으로 데이터 요청

//접근링크
//3.35.24.199
const _API_Login = "http://210.101.235.209:8760/authenticate";
const _API_Auth = "http://210.101.235.209:8760/signup";

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
  Future<void> postReq({username, password}) async {
    Response response;
    Dio dio = Dio();
    //login
    Map<String, dynamic> data={"username": username, "password": password};
    //register
    Map<String, dynamic> data1={"email": username, "password": password};
    // data.putIfAbsent("userId", () => 189);

    //DoPostRequest
    response = await dio.post(_API_Auth, data: data1);
    print("asdf"+response.data.toString());
  }

  //getRequestWithQuery
  Future<void> getReqWzQueery() async {
    Response response;
    Dio dio = Dio();
    // response = await dio.get(_API_PREFIX, queryParameters: {
    //   "id": 1, //id
    //   "pw": 2, //pw
    // });
    print(response.data.toString());
  }
}

Server server = Server();

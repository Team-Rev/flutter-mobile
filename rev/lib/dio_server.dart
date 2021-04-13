import 'package:dio/dio.dart';

//http형식으로 데이터 요청
const _API_PREFIX="https://?";

class Server{

  //Future란? 정리해서 올리기
  Future<void> getReq() async {
    //Response : Dio에서 가져와서 사용. Data 반환
    Response response;
    Dio dio=Dio();
    //DogetRequest
    response=await dio.get("{$_API_PREFIX}/1");
    print(response.data.toString());
  }
  Future<void> postReq() async {
    Response response;
    Dio dio=Dio();
    // Map<String, dynamic> data={"id":1, "name":"hihi"};
    // data.putIfAbsent("userId", () => 189);
    //DoPostRequest
    response=await dio.post(_API_PREFIX, data: {"id":1, "name":"hihi"});
    print(response.data.toString());
  }
  //getRequestWithQuery
  Future<void> getReqWzQueery() async {
    Response response;
    Dio dio=Dio();
    response=await dio.get(_API_PREFIX,queryParameters: {
      "userId":1,
      "id":2,
    });
    print(response.data.toString());
  }
}
Server server=Server();
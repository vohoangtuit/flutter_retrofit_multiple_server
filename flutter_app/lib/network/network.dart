import 'package:dio/dio.dart';
import 'package:flutter_app/network/request/user_request.dart';
import 'package:retrofit/retrofit.dart';
import 'base/user_base_response.dart';
part 'network.g.dart';
// https://github.com/trevorwang/retrofit.dart/
// todo: delete old file network.g.dart
// todo: run comment restclient.g.dart =// cd root project : flutter pub run build_runner build
//@RestApi(baseUrl: "https://vohoangtu-authencation.herokuapp.com/api/")
@RestApi(baseUrl: "")
abstract class Network {
  factory Network(Dio dio, {String baseUrl}) {
    Map<String, dynamic> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '<Your token>',
      'Language': 'vi'
    };
    dio.options = BaseOptions(
        receiveTimeout: 7000,
        connectTimeout: 7000,
       // contentType: 'application/json',
        headers: requestHeaders,

    );
    dio.interceptors.add(LogInterceptor(requestBody: true,responseBody: true));
    return _Network(dio, baseUrl: baseUrl);
  }

  @POST("user/login")
  Future<UserBaseResponseModel> login(@Body() UserRequest userLogin);

  @POST("user/create")
  Future<UserBaseResponseModel> register(@Body() UserRequest create);
}

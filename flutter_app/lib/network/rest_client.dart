import 'package:dio/dio.dart';
import 'package:flutter_app/base/bases_statefulwidget.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/network/request/user_request.dart';

import 'base/server_errror.dart';
import 'base/user_base_response.dart';
import 'network.dart';

class RestClient{
  Dio dio;
  Network network;
 final BaseStatefulState baseStatefulState;
 final String BASE_URL;
//  final Function(String message) errorMessage;
  RestClient({this.baseStatefulState,this.BASE_URL}) {
    dio = new Dio();
    network = new Network(dio,baseUrl: BASE_URL);
  }
  Future<UserBaseResponseModel> login(UserRequest userLogin) async {
    UserModel userModel;
    try {
      UserBaseResponseModel response = await network.login(userLogin);
      if(response!=null){
        if(response.user!=null){
          userModel =response.user;
        }else{
          return UserBaseResponseModel(status:response.status,message:response.message,token:'',user:null);
        }
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return UserBaseResponseModel(status:0,message:ServerError().getError(error),token:'',user:null);
     // baseStatefulState.showBaseDialog("Error",ServerError().getError(error));
     // return UserBaseResponseModel()..setException(ServerError.withError(error: error));
    }
    return UserBaseResponseModel()..user = userModel;
  }
  Future<UserBaseResponseModel> register(UserRequest userLogin) async {
    UserModel userModel;
    try {
      UserBaseResponseModel response = await network.register(userLogin);
      if(response!=null){
        if(response.user!=null){
          userModel =response.user;
        }else{
          return UserBaseResponseModel(status:response.status,message:response.message,token:'',user:null);
        }
      }
    } catch (error, stacktrace) {
      baseStatefulState.showBaseDialog("Error",ServerError().getError(error));
      return UserBaseResponseModel()..setException(ServerError.withError(error: error));
    }
    return UserBaseResponseModel()..user = userModel;
  }
}
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:zeroori_customer/models/user.dart';
import 'package:zeroori_customer/resources/string_resources.dart';
//import 'package:http/http.dart' as http;
class LoginServices {

  static Future<User> login(username,password) async {
    try {
      Response response = await Dio().post(UrlResources.loginUrl,data: {
        'username':username.toString(),
        'password':password.toString()
      });
      print(response);
      var res = json.decode(response.data);
      if(res['status'] == true){
        User user = User.fromJson(res['data']);
        if(user.userType == 'customer')
          return user;
        else
          throw Exception("Invalid User");
      }else{
        throw Exception(res['message']);
      }
    } on DioError catch (e) {
      throw Exception("Internal Error");
    }
  }
}
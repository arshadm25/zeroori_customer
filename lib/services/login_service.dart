import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:zeroori_customer/models/user.dart';
import 'package:zeroori_customer/resources/string_resources.dart';

class LoginServices {
  static Future<User> login(username, password) async {
    try {
      Response response = await Dio().post(UrlResources.loginUrl, data: {
        'username': username.toString(),
        'password': password.toString()
      });
      print(response);
      var res = json.decode(response.data);
      if (res['status'] == true) {
        User user = User.fromJson(res['data']);
        if (user.userType == 'customer')
          return user;
        else
          throw Exception("Invalid User");
      } else {
        throw Exception(res['message']);
      }
    } on DioError catch (e) {
      print("ZEROORI :" + e.response.data);
      throw Exception("Internal Error");
    }
  }

  static Future<bool> register(name,phone,email,password,address,country,pin,image) async {
    try {
      FormData formData = new FormData.fromMap({
        "name": name,
        "email": email,
        "phone":phone,
        "password":password,
        "pincode":pin,
        "image":await MultipartFile.fromFile(image.path, filename: image.path),
        "country":country,
        "address":address,
      });

      Response response = await Dio().post(UrlResources.registerUrl, data: formData);

      var res = json.decode(response.data);
      if (res['status'] == true) {
        return true;
      } else {
        throw Exception(res['message']);
      }
    } on DioError catch (e) {
      print("ZEROORI :" + e.response.data);
      throw Exception("Internal Error");
    } catch (e) {
      print("ZEROORI :" + e.toString());
    }
  }

  static Future<bool> passwordResetRequest(email) async {
    try {
      Response response = await Dio().post(UrlResources.registerUrl, data: {
        "email":email
      });

      var res = json.decode(response.data);
      if (res['status'] == true) {
        return true;
      } else {
        throw Exception(res['message']);
      }
    } on DioError catch (e) {
      print("ZEROORI :" + e.response.data);
      throw Exception("Internal Error");
    } catch (e) {
      print("ZEROORI :" + e.toString());
    }
  }
}

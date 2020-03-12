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
    } on DioError {
      throw Exception("Internal Server Error");
    }
  }

  static Future<bool> register(
    name,
    phone,
    email,
    password,
//    address,
    image,
    door,
    building,
    street,
    city,
    location,
  ) async {
    try {
      FormData formData = new FormData.fromMap({
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
        "image": await MultipartFile.fromFile(image.path, filename: image.path),
//        "address": address,
        "door": door,
        "building": building,
        "street": street,
        "city": city,
        "location":location,
      });

      Response response =
          await Dio().post(UrlResources.registerUrl, data: formData);

      var res = json.decode(response.data);
      if (res['status'] == true) {
        return true;
      } else {
        throw Exception(res['message']);
      }
    } on DioError {
      throw Exception("Internal Server Error");
    }
  }

  static Future<String> passwordResetRequest(email) async {
    try {
      Response response =
          await Dio().post(UrlResources.forgot_pass, data: {"email": email});
      var res = json.decode(response.data);
      if (res['status'] == true) {
        return res['message'];
      } else {
        throw Exception(res['message']);
      }
    } on DioError {
      throw Exception("Internal Server Error");
    }
  }

  static Future<String> otpConfirm(otp, email) async {
    try {
      Response response = await Dio().post(UrlResources.enter_otp,
          data: {"entered_otp": otp, "email": email});
      var res = json.decode(response.data);
      if (res['status'] == true) {
        return res['message'];
      } else {
        throw Exception(res['message']);
      }
    } on DioError {
      throw Exception("Internal Server Error");
    }
  }

  static Future<String> resetPassword(password, email) async {
    try {
      Response response = await Dio().post(UrlResources.reset_pass,
          data: {"password": password, "email": email});
      var res = json.decode(response.data);
      if (res['status'] == true) {
        return res['message'];
      } else {
        throw Exception(res['message']);
      }
    } on DioError {
      throw Exception("Internal Server Error");
    }
  }
}

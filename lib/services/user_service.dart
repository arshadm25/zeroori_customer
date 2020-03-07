import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:zeroori_customer/models/user.dart';
import 'package:zeroori_customer/resources/string_resources.dart';

class UserService {
  static Future<bool> mailUs(message) async {
    try {
      Response response =
          await Dio().post(UrlResources.email_us, data: {'message': message});
      Map<String, dynamic> res = json.decode(response.data);

      if (res['status'] == true) {
        return true;
      } else {
        throw Exception(res['message']);
      }
    } on DioError {
      throw Exception("Internal Server Error");
    }
  }

  static Future<bool> reportUs(message) async {
    try {
      Response response =
          await Dio().post(UrlResources.report_us, data: {'message': message});
      Map<String, dynamic> res = json.decode(response.data);

      if (res['status'] == true) {
        return true;
      } else {
        throw Exception(res['message']);
      }
    } on DioError {
      throw Exception("Internal Server Error");
    }
  }

  static Future<User> updateUser(data) async {
    try {
      FormData formData = FormData.fromMap({
        'id': data['id'],
        'name': data['name'],
        'address': data['address'],
        'country': data['country'],
        'pincode': data['zip'],
        'door': data['door'],
        'building': data['building'],
        'street': data['street'],
        'city': data['city'],
        'image': data['image'] != null
            ? await MultipartFile.fromFile(data['image'].path,
                filename: data['image'].path)
            : null,
        'profile': data['temp']
      });
      Response response =
          await Dio().post(UrlResources.update_user, data: formData);
      Map<String, dynamic> res = json.decode(response.data);

      if (res['status'] == true) {
        User user = User.fromJson(res['data']);
        return user;
      } else {
        throw Exception(res['message']);
      }
    } on DioError {
      throw Exception("Internal Server Error");
    }
  }
}

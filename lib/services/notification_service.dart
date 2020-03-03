import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:zeroori_customer/models/notifications.dart';
import 'package:zeroori_customer/resources/string_resources.dart';

class NotificationService{
  static Future<List<Notifications>> getNotifications(int userId) async {
    try {
      Response response =
      await Dio().post(UrlResources.notification_list, data: {"user_id": userId});
      Map<String,dynamic> res = json.decode(response.data);
      if (res['status'] == true) {
        List collection = res['data'];
        List<Notifications> notifications= collection.map((v)=>Notifications.fromJson(v)).toList();
        return notifications;
      } else {
        throw Exception(res['message']);
      }
    } on DioError {
      throw Exception("Internal Server Error");
    }
  }
}
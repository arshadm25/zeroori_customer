import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zeroori_customer/models/order.dart';
import 'package:zeroori_customer/resources/string_resources.dart';

enum OrderStatus { IN_PROGRESS, COMPLETED, NEW, ALL, PROCESSING, CANCELLED }

class StatusConverter {
  OrderStatus setStatus(String status) {
    switch (status) {
      case "new":
        return OrderStatus.NEW;
      case "completed":
        return OrderStatus.COMPLETED;
      case "progressing":
        return OrderStatus.IN_PROGRESS;
      case "processing":
        return OrderStatus.PROCESSING;
      case "cancelled":
        return OrderStatus.CANCELLED;
      default:
        return OrderStatus.ALL;
    }
  }

  String getStatus(OrderStatus status) {
    switch (status) {
      case OrderStatus.IN_PROGRESS:
        return "progressing";
      case OrderStatus.PROCESSING:
        return "processing";
      case OrderStatus.COMPLETED:
        return "completed";
      case OrderStatus.NEW:
        return "new";
      case OrderStatus.CANCELLED:
        return "cancelled";
      default:
        return "";
    }
  }
}

class OrderService {
  static Future<List<Order>> getOrders(int userId, OrderStatus status) async {
    try {
      Response response = await Dio().post(UrlResources.orders, data: {
        "user_id": userId,
        'status': StatusConverter().getStatus(status)
      });
      Map<String, dynamic> res = json.decode(response.data);

      if (res['status'] == true) {
        List collection = res['data'];
        List<Order> orders = collection.map((v) => Order.fromJson(v)).toList();
        return orders;
      } else {
        throw Exception(res['message']);
      }
    } on DioError {
      throw Exception("Internal Server Error");
    }
  }

  static Future<bool> createOrder(int userId, Map<String, dynamic> data) async {
    try {
      var map = {
        'area': data['area'].name,
        'address': data['address'],
        'problem': data['problem'],
        'time': data['time'],
        'time1':data['time1'],
        'service': data['service'],
        'sub_category': data['sub_category'],
        'user_id': userId,
      };
      int i = 0;
      for (i = 1; i < data['images'].length + 1; i++) {
        var temp = await MultipartFile.fromFile(data['images'][i - 1].path,
            filename: data['images'][i - 1].path);
        map.addAll({"image$i": temp});
      }
      FormData formData = new FormData.fromMap(map);
      Response response = await Dio().post(
        UrlResources.create_order,
        data: formData,
      );
      Map<String, dynamic> res = json.decode(response.data);

      if (res['status'] == true) {
        return true;
      } else {
        throw Exception(res['message']);
      }
    } on DioError {
      throw Exception("Internal Server Error");
    } catch (e) {
      throw Exception("Exteranl Error" + e.toString());
    }
  }

  static Future<bool> rateNow( Map<String, dynamic> data) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      int userId = preferences.getInt(SharedResources.USER_ID);

      var map = {
        'user_id': userId,
        'job_id': data['job'],
        'rating': data['rating'],
        'description': data['description'],
      };
      FormData formData = new FormData.fromMap(map);
      Response response = await Dio().post(
        UrlResources.rateOrder,
        data: formData,
      );
      Map<String, dynamic> res = json.decode(response.data);

      if (res['status'] == true) {
        return true;
      } else {
        throw Exception(res['message']);
      }
    } on DioError {
      throw Exception("Internal Server Error");
    } catch (e) {
      throw Exception("Exteranl Error" + e.toString());
    }
  }
  static Future<bool> completeorCancelOrder(int id, OrderStatus status) async {
    try {
      Response response = await Dio().post(UrlResources.confirm_order,
          data: {"id": id, 'status': StatusConverter().getStatus(status)});
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
}

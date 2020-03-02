import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:zeroori_customer/models/Service.dart';
import 'package:zeroori_customer/resources/string_resources.dart';

import '../models/sub_service.dart';

class CategoryServices {
  static Future<List<Service>> getServices() async {
    try {
      Response response = await Dio().post(UrlResources.services);
      Map<String, dynamic> result = json.decode(response.data);
      if (result['status'] == true) {
        List collection = result['data'];
        return collection.map((s) => Service.fromJson(s)).toList();
      } else {
        throw Exception("Internal Server Error");
      }
    } on DioError catch (e) {
      throw Exception(e.response.data);
    }
  }

  static Future<List<SubService>> getSubServices(int id) async {
    try {
      Response response = await Dio().post(UrlResources.sub_services,data:{
        'category_id':id.toString()
      });
      Map<String, dynamic> result = json.decode(response.data);
      if (result['status'] == true) {
        List collection = result['data'];
        return collection.map((s) => SubService.fromJson(s)).toList();
      } else {
        throw Exception("Internal Server Error");
      }
    } on DioError catch (e) {
      throw Exception(e.response.data);
    }
  }
}

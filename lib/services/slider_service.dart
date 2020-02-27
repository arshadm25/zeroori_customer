import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:zeroori_customer/models/slider.dart';
import 'package:zeroori_customer/resources/string_resources.dart';

class SliderService{
  static Future<List<Slider>> getSliders() async {
    try{
      Response response = await Dio().post(UrlResources.sliders);
      Map<String,dynamic> result = json.decode(response.data);
      if(result['status'] == true){
        List collection = result['data'];
        return collection.map((s)=>Slider.fromJson(s)).toList();
      }else{
        throw Exception("Internal Server Error");
      }
    } on DioError catch(e){
      throw Exception(e.response.data);
    }
  }
}
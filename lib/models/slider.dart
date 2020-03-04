import 'package:zeroori_customer/resources/string_resources.dart';

class Slider{
  final int id;
  final String image;

  Slider(this.id, this.image,);

  factory Slider.fromJson(Map<String,dynamic> js){
    return Slider(
      int.parse(js['pk_int_slider_id'].toString()),
      UrlResources.mainUrl + js['vchr_slider_image'],
    );
  }
}
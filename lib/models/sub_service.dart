import 'package:zeroori_customer/resources/string_resources.dart';

class SubService{
  final int id;
  final String name;
  final String image;

  SubService(this.id, this.name, this.image);

  factory SubService.fromJson(Map<String, dynamic> js) {
    return SubService(
      int.parse(js['pk_int_sub_category_id'].toString()),
      js['vchr_sub_category_name'].toString(),
      UrlResources.mainUrl + js['vchr_sub_category_image'].toString(),
    );
  }
}
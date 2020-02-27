import 'package:zeroori_customer/resources/string_resources.dart';

class Service {
  final int id;
  final String name;
  final String image;
  final String description;

  Service(this.id, this.name, this.image, this.description);

  factory Service.fromJson(Map<String, dynamic> js) {
    return Service(
      int.parse(js['pk_int_category_id'].toString()),
      js['vchr_category_name'].toString(),
      UrlResources.mainUrl + js['vchr_category_image'].toString(),
      js['vchr_category_description'].toString(),
    );
  }
}

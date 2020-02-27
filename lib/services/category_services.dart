import 'package:zeroori_customer/models/Service.dart';

import '../models/sub_service.dart';

class CategoryServices {
  static Future<List<Service>> getServices() async {
    return Future.value([
      Service(
        1,
        "Air Conditioner",
        "assets/air_conditioner.png",
        "asd",
      ),
      Service(
          1,
          "Electrical Works",
          "assets/electrical.png",
          "asdf"
      ),
      Service(
          1,
          "Furniture",
          "assets/furniture.png",
          "adf"
      ),
      Service(
          1,
          "Painting",
          "assets/painting.png",
          "adsf"
      ),
      Service(
          1,
          "Pest Control",
          "assets/pest_control.png",
          "adsf"
      ),
      Service(
          1,
          "Plumbing",
          "assets/plumbing.png",
          "adsf"
      ),
      Service(
          1,
          "Satellite",
          "assets/satellite.png",
          "adsf"
      ),
      Service(
          1,
          "Cleaning & Home Maids",
          "assets/vacuum_cleaner.png",
          "adsf"
      ),
    ]);
  }

  static Future<List<SubService>> getSubServices(int id) async {
    return Future.value( [
      SubService(
        "Air Conditioner",
        "assets/air_conditioner.png",
      ),
      SubService(
        "Electrical Works",
        "assets/electrical.png",
      ),
      SubService(
        "Furniture",
        "assets/furniture.png",
      ),
    ]);
  }
}
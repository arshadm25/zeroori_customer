import 'package:zeroori_customer/models/area.dart';

class AreaServices {
  static List<Area> getAreas() {
    return [
      Area(false, "Doha"),
      Area(false, "Al Wakrah"),
      Area(false, "Al Khor"),
      Area(false, "Al Rayyan"),
      Area(false, "Al Gowarriya"),
      Area(false, "Aljamilya"),
    ];
  }
}

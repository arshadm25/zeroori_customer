import 'package:zeroori_customer/models/slider.dart';

class SliderService{
  static Future<List<Slider>> getSliders() async {
    return Future.value(List.generate(4, (index)=>Slider(
        index,
        "assets/wood.jpg"
    ),));
  }
}
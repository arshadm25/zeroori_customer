import 'package:flutter/cupertino.dart';

class CustomRect extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    Rect rect = Rect.fromLTRB(size.width * 1.5, size.width, -size.width / 2, 0);
    return rect;
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}

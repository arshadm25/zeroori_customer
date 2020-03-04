import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'color_resources.dart';

class StyleResources {
  static TextStyle notificationContent() {
    return TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15);
  }

  static TextStyle notificationDate() {
    return TextStyle(
        color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 15);
  }

  static TextStyle primaryButton() {
    return secondaryButton().copyWith(
      color: Colors.white,
    );
  }

  static TextStyle secondaryButton() {
    return TextStyle(
      color: ColorResources.primaryColor,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    );
  }

  static TextStyle title(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .title
        .copyWith(color: ColorResources.primaryColor);
  }

  static TextStyle titleUnderlined(BuildContext context) {
    return title(context).copyWith(decoration: TextDecoration.underline);
  }

  static TextStyle dialogHeader(BuildContext context) {
    return Theme.of(context).textTheme.headline.copyWith(
        fontWeight: FontWeight.bold, color: ColorResources.primaryColor);
  }

  static TextStyle dialogContent(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .body2
        .copyWith(color: ColorResources.primaryColor);
  }
}

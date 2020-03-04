import 'package:flutter/material.dart';
import 'package:zeroori_customer/widgets/dialogs/loader_dialog.dart';
import 'package:zeroori_customer/widgets/dialogs/message_dialog.dart';

class Dialogs {
  static showLoader(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => LoaderDialog(),
    );
  }

  static showMessage(BuildContext context,
      {VoidCallback onClose, message, title: "Message"}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => MessageDialog(
        onClose: onClose,
        message: message,
        title: title,
      ),
    );
  }
}

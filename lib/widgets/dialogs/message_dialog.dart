import 'package:flutter/material.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/resources/string_resources.dart';
import 'package:zeroori_customer/resources/style_resources.dart';

class MessageDialog extends StatefulWidget {
  final String title;
  final String message;
  final VoidCallback onClose;

  const MessageDialog({Key key, this.title, this.message, this.onClose})
      : super(key: key);

  @override
  _MessageDialogState createState() => _MessageDialogState();
}

class _MessageDialogState extends State<MessageDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          width: 300,
          height: MediaQuery.of(context).size.height / 5,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                  right: 5,
                  top: 5,
                  child: InkWell(
                    onTap: this.widget.onClose ??
                        () {
                          Navigator.pop(context);
                        },
                    child: Container(
                      padding: EdgeInsets.all(1.0),
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      child: Icon(Icons.close),
                    ),
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    widget.title,
                    style: StyleResources.dialogHeader(context),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.message,
                    textAlign: TextAlign.center,
                    style: StyleResources.dialogContent(context),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      color: ColorResources.primaryColor,
                      child: Text(
                        StringResources.ok,
                        style: StyleResources.primaryButton(),
                      ),
                      onPressed: this.widget.onClose ??
                          () {
                            Navigator.pop(context);
                          },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

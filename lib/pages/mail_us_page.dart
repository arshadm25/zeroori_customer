import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/resources/style_resources.dart';
import 'package:zeroori_customer/widgets/dialogs/message_dialog.dart';

class MailUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Color(0x8D1B3D).withOpacity(1),
          title: Text("Mail Us")),
      backgroundColor: ColorResources.secondaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        offset: Offset(3, 3),
                        color: Colors.grey.withOpacity(0.5))
                  ]),
                  height: (MediaQuery.of(context).size.height / 3) *1.2,                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
//                          Icon(
//                            Icons.chat_bubble,
//                            color: ColorResources.primaryColor,
//                            size: 100,
//                          ),
                          Text(
                            "Mail Us",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "enter your mail in details so that we will understand your problem well",
                            maxLines: 3,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                          TextField(
                            maxLines: 5,
                            decoration: InputDecoration(
                              hintText: "Enter your Mail here...",
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                    color: ColorResources.primaryColor,
                    onPressed: () {
                      showDialog(context: context,builder: (context){
                        return MessageDialog(
                          title: "Sucess",
                          message: "Your mail has been submitted successfully",
                          onClose: (){
                            Navigator.pop(context);
                          },
                        );
                      });
                    },
                    child: Text(
                      "Send",
                      style: StyleResources.primaryButton(),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

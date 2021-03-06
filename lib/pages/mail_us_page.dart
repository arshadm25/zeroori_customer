import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/resources/string_resources.dart';
import 'package:zeroori_customer/resources/style_resources.dart';
import 'package:zeroori_customer/services/user_service.dart';
import 'package:zeroori_customer/utils/app_translations.dart';
import 'package:zeroori_customer/utils/dialogs.dart';

class MailUsPage extends StatefulWidget {
  @override
  _MailUsPageState createState() => _MailUsPageState();
}

class _MailUsPageState extends State<MailUsPage> {
  TextEditingController mailController;

  @override
  void initState() {
    super.initState();
    mailController = TextEditingController();
  }

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
          title: Text(AppTranslations.of(context).text(StringResources.mail_us))),
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
                  height: (MediaQuery.of(context).size.height / 3) * 1.2,
                  child: SingleChildScrollView(
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
                            AppTranslations.of(context).text(StringResources.mail_us),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            AppTranslations.of(context).text(StringResources.enter_your_mail_in_details),
                            maxLines: 3,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                          TextField(
                            maxLines: 5,
                            controller: mailController,
                            decoration: InputDecoration(
                              hintText: AppTranslations.of(context).text(StringResources.enter_your_mail_here),
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
                      Dialogs.showLoader(context);
                      UserService.mailUs(mailController.text).then((v) {
                        Navigator.pop(context);
                        Dialogs.showMessage(context,
                            title: AppTranslations.of(context).text(StringResources.success),
                            message:
                            AppTranslations.of(context).text(StringResources.mail_has_been_submitted));
                      }).catchError((e) {
                        Navigator.pop(context);
                        Dialogs.showMessage(context,
                            title: AppTranslations.of(context).text(StringResources.oops),
                            message:
                            AppTranslations.of(context).text(StringResources.sorry_some_error_occured) + e.toString(),
                            onClose: () {});
                      });
                    },
                    child: Text(
                      AppTranslations.of(context).text(StringResources.send),
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

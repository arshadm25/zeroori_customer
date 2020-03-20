import 'package:flutter/material.dart';
import 'package:zeroori_customer/pages/enter_otp_page.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/resources/string_resources.dart';
import 'package:zeroori_customer/services/login_service.dart';
import 'package:zeroori_customer/utils/app_translations.dart';
import 'package:zeroori_customer/utils/dialogs.dart';

class ForgotPassworedPage extends StatefulWidget {
  @override
  _ForgotPassworedPageState createState() => _ForgotPassworedPageState();
}

class _ForgotPassworedPageState extends State<ForgotPassworedPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.secondaryColor,
      appBar: AppBar(
        leading: IconButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back ,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorResources.primaryColor,
        title: Text(AppTranslations.of(context).text(StringResources.forgotPassword).toUpperCase()),
      ),
      body: SafeArea(
        child:  Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 25,
                ),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 25,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              AppTranslations.of(context).text(StringResources.forgotPassword),
                              style: Theme.of(context).textTheme.headline,
                            ),
                            Text(
                              AppTranslations.of(context).text(StringResources.enterYourEmailToContinue),
                              style: Theme.of(context).textTheme.caption,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    decoration: InputDecoration(
                                      labelText:AppTranslations.of(context).text(StringResources.email),
                                      hasFloatingPlaceholder: true,
                                    ),
                                    controller: emailController,
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return AppTranslations.of(context).text(StringResources.pleaseEnterYourEmail);
                                      }
                                      if (val.length < 8) {
                                        return AppTranslations.of(context).text(StringResources.pleaseEnterValidEmail);
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 25,
                  height: 60,
                  child: RaisedButton(
                    color: ColorResources.primaryColor,
                    child: Text(
                        AppTranslations.of(context).text(StringResources.submit).toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () {
                      Dialogs.showLoader(context);
                      if (_formKey.currentState.validate()) {
                        _onResetPassword();
                      } else {
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onResetPassword() {
    LoginServices.passwordResetRequest(emailController.text).then((s) {
      Navigator.pop(context);
      Dialogs.showMessage(context, title:AppTranslations.of(context).text(StringResources.success), message: s,
          onClose: () {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    EnterOtpPage(email: emailController.text)));
      });
    }).catchError((e) {
      Navigator.pop(context);
      Dialogs.showMessage(
        context,
        title:AppTranslations.of(context).text(StringResources.oops),
        message: e.toString().replaceAll(
          AppTranslations.of(context).text(StringResources.exception),
              StringResources.emptyString,
            ),
        onClose: (){
          Navigator.pop(context);
          Navigator.pop(context);
        }
      );
    });
  }
}

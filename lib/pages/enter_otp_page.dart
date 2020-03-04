import 'package:flutter/material.dart';
import 'package:zeroori_customer/pages/BasePage.dart';
import 'package:zeroori_customer/pages/reset_password_page.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/resources/string_resources.dart';
import 'package:zeroori_customer/services/login_service.dart';
import 'package:zeroori_customer/utils/dialogs.dart';

class EnterOtpPage extends StatefulWidget {
  final String email;

  const EnterOtpPage({Key key, this.email}) : super(key: key);

  @override
  _EnterOtpPagePageState createState() => _EnterOtpPagePageState();
}

class _EnterOtpPagePageState extends State<EnterOtpPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController otpController;

  @override
  void initState() {
    super.initState();
    otpController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: StringResources.forgotPassword,
      hasBack: true,
      child: Container(
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
                            StringResources.enterOtp,
                            style: Theme.of(context).textTheme.headline,
                          ),
                          Text(
                            StringResources.enterOtpToContinue,
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
                                    labelText: StringResources.otp,
                                    hasFloatingPlaceholder: true,
                                  ),
                                  controller: otpController,
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return StringResources.pleaseEnterOtp;
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
                    StringResources.submit.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () {
                    Dialogs.showLoader(context);
                    if (_formKey.currentState.validate()) {
                      _onOtpConfirm();
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
    );
  }

  _onOtpConfirm() {
    LoginServices.otpConfirm(otpController.text, widget.email).then((s) {
      Navigator.pop(context);
      Dialogs.showMessage(context, title: StringResources.success, message: s,
          onClose: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ResetPasswordPage(
                      email: widget.email,
                    )));
      });
    }).catchError((e) {
      Navigator.pop(context);
      Dialogs.showMessage(
        context,
        title: StringResources.oops,
        message: e.toString().replaceAll(
              StringResources.exception,
              StringResources.emptyString,
            ),
      );
    });
  }
}

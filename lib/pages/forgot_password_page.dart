import 'package:flutter/material.dart';
import 'package:zeroori_customer/pages/BasePage.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/resources/string_resources.dart';

class ForgotPassworedPage extends StatefulWidget {

  @override
  _ForgotPassworedPageState createState() => _ForgotPassworedPageState();
}

class _ForgotPassworedPageState extends State<ForgotPassworedPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Forgot Password",
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
                            "Forgot Password",
                            style: Theme.of(context).textTheme.headline,
                          ),
                          Text(
                            "Enter email to continue",
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
                                    labelText: "Email",
                                    hasFloatingPlaceholder: true,
                                  ),
                                  validator: (val){
                                    if (val.isEmpty) {
                                        return StringResources
                                            .pleaseEnterYourEmail;
                                      }
                                      if (val.length < 8) {
                                        return StringResources
                                            .pleaseEnterValidEmail;
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
                    "Submit".toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () {
                    if(_formKey.currentState.validate()){
                      _onResetPassword();
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

  _onResetPassword(){

  }
}

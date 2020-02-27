import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeroori_customer/bloc/user/bloc.dart';
import 'package:zeroori_customer/bloc/user/user_bloc.dart';
import 'package:zeroori_customer/models/user.dart';
import 'package:zeroori_customer/pages/BasePage.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/resources/string_resources.dart';
import 'package:zeroori_customer/resources/style_resources.dart';
import 'package:zeroori_customer/services/login_service.dart';
import 'package:zeroori_customer/utils/dialogs.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  RegExp regex;
  TextEditingController emailController;
  TextEditingController passwordController;
  UserBloc userBloc;



  @override
  void initState() {
    super.initState();
    regex = new RegExp(PatterStrings.email);
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userBloc = context.bloc<UserBloc>();
    userBloc.add(AppInitial());
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: StringResources.signIn.toUpperCase(),
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
                            StringResources.welcome,
                            style: Theme.of(context).textTheme.headline,
                          ),
                          Text(
                            StringResources.loginToContinue,
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
                                    labelText: StringResources.email,
                                    hasFloatingPlaceholder: true,
                                  ),
                                  controller: emailController,
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return StringResources
                                          .pleaseEnterYourEmail;
                                    }
                                    if (!regex.hasMatch(val)) {
                                      return StringResources
                                          .pleaseEnterValidEmail;
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: StringResources.password,
                                    hasFloatingPlaceholder: true,
                                  ),
                                  controller: passwordController,
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return StringResources
                                          .pleaseEnterYourPassword;
                                    }
                                    if (val.length < 8) {
                                      return StringResources
                                          .pleaseEnterValidPassword;
                                    }
                                    return null;
                                  },
                                  obscureText: true,
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
                    StringResources.signIn.toUpperCase(),
                    style: StyleResources.primaryButton(),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _onLogin();
                    }
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    "${StringResources.forgotPassword}? ",
                    style: StyleResources.title(context),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.forgotPage);
                    },
                    child: Text(
                      StringResources.clickHere,
                      style: StyleResources.titleUnderlined(context),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _onLogin() {
    LoginServices.login(emailController.text, passwordController.text).then((User v) async {
      Map<String,dynamic> jsonUser = User.toJson(v);
      String us = json.encode(jsonUser).toString();
      userBloc.add(LogIn(v.id,us));
      Navigator.popAndPushNamed(context, 'services');
    }).catchError((e){
      Dialogs.showMessage(context,message: e.toString().replaceAll("Exception:", ""),title: "Oops!");
    });
  }
}

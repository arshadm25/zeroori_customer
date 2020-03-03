import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/resources/string_resources.dart';
import 'package:zeroori_customer/resources/style_resources.dart';
import 'package:zeroori_customer/services/login_service.dart';
import 'package:zeroori_customer/utils/dialogs.dart';
import 'package:zeroori_customer/widgets/sign_up_header.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  File userImage;
  RegExp regex;
  RegExp pregex;
  TextEditingController nameController;
  TextEditingController phoneController;
  TextEditingController emailController;
  TextEditingController passwordController;
  TextEditingController addressController;
  TextEditingController countryController;
  TextEditingController pinController;

  @override
  void initState() {
    super.initState();
    regex = new RegExp(PatterStrings.email);
    pregex = new RegExp(PatterStrings.phone);
    nameController = TextEditingController();
    phoneController  = TextEditingController();
    emailController  = TextEditingController();
    passwordController = TextEditingController();
    addressController = TextEditingController();
    countryController = TextEditingController();
    pinController = TextEditingController();
    countryController.text = "Qatar";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SignUpHeader(
                file: userImage,
                onImageSelected: () async {
                  File file =
                      await ImagePicker.pickImage(source: ImageSource.camera);
                  setState(() {
                    userImage = file;
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: StringResources.name,
                          hasFloatingPlaceholder: true,
                        ),
                        controller: nameController,
                        validator: (val) {
                          if (val.isEmpty) {
                            return StringResources.pleaseEnterFirstName;
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: StringResources.phone,
                          hasFloatingPlaceholder: true,
                        ),
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val.isEmpty) {
                            return StringResources.pleaseEnterPhone;
                          }
                          if (!pregex.hasMatch(val)) {
                            return StringResources.pleaseEnterValidPhone;
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: StringResources.email,
                          hasFloatingPlaceholder: true,
                        ),
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) {
                          if (val.isEmpty) {
                            return StringResources.pleaseEnterYourEmail;
                          }
                          if (!regex.hasMatch(val)) {
                            return StringResources.pleaseEnterValidEmail;
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
                            return StringResources.pleaseEnterYourPassword;
                          }
                          if (val.length < 8) {
                            return StringResources.pleaseEnterPasswordMinimum8;
                          }
                          return null;
                        },
                        obscureText: true,
                      ),
                      TextFormField(
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: StringResources.addresss,
                          hasFloatingPlaceholder: true,
                        ),
                        controller: addressController,
                        validator: (val) {
                          if (val.isEmpty) {
                            return StringResources.pleaseEnterAddress;
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: StringResources.country,
                          hasFloatingPlaceholder: true,
                        ),
                        controller: countryController,
                        validator: (val) {
                          if (val.isEmpty) {
                            return StringResources.pleaseEnterCountry;
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: StringResources.postal,
                          hasFloatingPlaceholder: true,
                        ),
                        controller: pinController,
                        validator: (val) {
                          if (val.isEmpty) {
                            return StringResources.pleaseEnterPostal;
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 1.5,
                          height: MediaQuery.of(context).size.width / 8,
                          child: RaisedButton(
                            onPressed: () {
                              Dialogs.showLoader(context);
                              if (userImage == null) {
                                Navigator.pop(context);
                                Dialogs.showMessage(context,
                                    title: StringResources.oops,
                                    message: StringResources.pleaseSelectImage);
                              } else {
                                if (_formKey.currentState.validate()) {
                                  _registerUser();
                                } else {
                                  Navigator.pop(context);
                                  Dialogs.showMessage(context,
                                      title: StringResources.oops,
                                      message:
                                          StringResources.pleaseFillAllFields);
                                }
                              }
                            },
                            color: ColorResources.primaryColor,
                            child: Text(
                              StringResources.signUp,
                              style: StyleResources.primaryButton(),
                            ),
                          )),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _registerUser(){
    LoginServices.register(nameController.text, phoneController.text, emailController.text, passwordController.text, addressController.text, countryController.text, pinController.text, userImage).then((v){
      Dialogs.showMessage(context,title: StringResources.success,message: StringResources.userRegisteredSuccessfully,onClose: (){
        Navigator.popAndPushNamed(context,RouteNames.loginPage);
      });
    }).catchError((e){
      Dialogs.showMessage(context,title: StringResources.oops,message: e.toString().replaceAll(StringResources.exception, StringResources.emptyString),onClose: (){
        Navigator.popAndPushNamed(context,RouteNames.loginPage);
      });
    });
  }
}

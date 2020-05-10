import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/resources/string_resources.dart';
import 'package:zeroori_customer/resources/style_resources.dart';
import 'package:zeroori_customer/services/login_service.dart';
import 'package:zeroori_customer/utils/app_translations.dart';
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
  String location;
  TextEditingController nameController;
  TextEditingController phoneController;
  TextEditingController emailController;
  TextEditingController passwordController;
//  TextEditingController addressController;
  TextEditingController doorController;
  TextEditingController buildingController;
  TextEditingController streetController;
  TextEditingController cityController;

  @override
  void initState() {
    super.initState();
    regex = new RegExp(PatterStrings.email);
    pregex = new RegExp(PatterStrings.phone);
    nameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
//    addressController = TextEditingController();
    doorController = TextEditingController();
    buildingController = TextEditingController();
    streetController = TextEditingController();
    cityController = TextEditingController();
    location = null;
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
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                            title: Text(AppTranslations.of(context).text(StringResources.choose_source)),
                            content: Text(AppTranslations.of(context).text(StringResources.how_you_want_to_select)),
                            actions: [
                              FlatButton(
                                  onPressed: () async {
                                    File file = await ImagePicker.pickImage(
                                        source: ImageSource.camera);
                                    setState(() {
                                      userImage = file;
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Text(AppTranslations.of(context).text(StringResources.camera))),
                              FlatButton(
                                  onPressed: () async {
                                    File file = await ImagePicker.pickImage(
                                        source: ImageSource.gallery);
                                    setState(() {
                                      userImage = file;
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Text(AppTranslations.of(context).text(StringResources.gallery)))
                            ]);
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
                          labelText:AppTranslations.of(context).text(StringResources.name),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                        controller: nameController,
                        validator: (val) {
                          if (val.isEmpty) {
                            return AppTranslations.of(context).text(StringResources.pleaseEnterFirstName);
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: AppTranslations.of(context).text(StringResources.phone),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val.isEmpty) {
                            return AppTranslations.of(context).text(StringResources.pleaseEnterPhone);
                          }
                          if (!pregex.hasMatch(val)) {
                            return AppTranslations.of(context).text(StringResources.pleaseEnterValidPhone);
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: AppTranslations.of(context).text(StringResources.email),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) {
                          if (val.isEmpty) {
                            return AppTranslations.of(context).text(StringResources.pleaseEnterYourEmail);
                          }
                          if (!regex.hasMatch(val)) {
                            return AppTranslations.of(context).text(StringResources.pleaseEnterValidEmail);
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: AppTranslations.of(context).text(StringResources.password),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                        controller: passwordController,
                        validator: (val) {
                          if (val.isEmpty) {
                            return AppTranslations.of(context).text(StringResources.pleaseEnterYourPassword);
                          }
                          if (val.length < 8) {
                            return AppTranslations.of(context).text(StringResources.pleaseEnterPasswordMinimum8);
                          }
                          return null;
                        },
                        obscureText: true,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: AppTranslations.of(context).text(StringResources.doorNo),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                        controller: doorController,
//                        validator: (val) {
//                          if (val.isEmpty) {
//                            return StringResources.pleaseEnterDoorNo;
//                          }
//                          return null;
//                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: AppTranslations.of(context).text(StringResources.building),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                        controller: buildingController,
//                        validator: (val) {
//                          if (val.isEmpty) {
//                            return StringResources.pleaseEnterBuilding;
//                          }
//                          return null;
//                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: AppTranslations.of(context).text(StringResources.street),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                        controller: streetController,
//                        validator: (val) {
//                          if (val.isEmpty) {
//                            return StringResources.pleaseEnterStreet;
//                          }
//                          return null;
//                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: AppTranslations.of(context).text(StringResources.city),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                        controller: cityController,
//                        validator: (val) {
//                          if (val.isEmpty) {
//                            return StringResources.pleaseEnterCity;
//                          }
//                          return null;
//                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(AppTranslations.of(context).text(StringResources.location))),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: DropdownButton<String>(
                          underline: Divider(
                            color: Colors.grey,
                            height: 2,
                          ),
                          isExpanded: true,
                          value: location,
                          onChanged: (val) {
                            setState(() {
                              location = val;
                            });
                          },
                          items: [
                            DropdownMenuItem(
                              child: Text(AppTranslations.of(context).text(StringResources.select_location)),
                              value: null,
                            ),
                            DropdownMenuItem(
                              child: Text(AppTranslations.of(context).text(StringResources.ground_floor)),
                              value: AppTranslations.of(context).text(StringResources.ground_floor),
                            ),
                            DropdownMenuItem(
                              child: Text(AppTranslations.of(context).text(StringResources.upstair)),
                              value: AppTranslations.of(context).text(StringResources.upstair),
                            ),
                            DropdownMenuItem(
                              child: Text(AppTranslations.of(context).text(StringResources.seperate_house)),
                              value: AppTranslations.of(context).text(StringResources.seperate_house),
                            )
                          ],
                        ),
                      ),
//                      TextFormField(
//                        maxLines: 3,
//                        decoration: InputDecoration(
//                          labelText: StringResources.addresss +" (Optional)",
//                          hasFloatingPlaceholder: true,
//                        ),
//                        controller: addressController,
////                        validator: (val) {
////                          if (val.isEmpty) {
////                            return StringResources.pleaseEnterAddress;
////                          }
////                          return null;
////                        },
//                      ),
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
                                  title: AppTranslations.of(context).text(StringResources.oops),
                                  message:AppTranslations.of(context).text(StringResources.pleaseSelectImage));
                            } else {
                              if (_formKey.currentState.validate()) {
                                _registerUser();
                              } else {
                                Navigator.pop(context);
                                Dialogs.showMessage(context,
                                    title: AppTranslations.of(context).text(StringResources.oops),
                                    message:
                                    AppTranslations.of(context).text(StringResources.pleaseFillAllFields));
                              }
                            }
                          },
                          color: ColorResources.primaryColor,
                          child: Text(
                            AppTranslations.of(context).text(StringResources.signUp),
                            style: StyleResources.primaryButton(),
                          ),
                        ),
                      ),
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

  _registerUser() {
    LoginServices.register(
      nameController.text,
      phoneController.text,
      emailController.text,
      passwordController.text,
//      addressController.text,
      userImage,
      doorController.text,
      buildingController.text,
      streetController.text,
      cityController.text,
      location,
    ).then((v) {
      Navigator.pop(context);
      Dialogs.showMessage(context,
          title: AppTranslations.of(context).text(StringResources.success ),
          message: AppTranslations.of(context).text(StringResources.userRegisteredSuccessfully ), onClose: () {
        Navigator.pop(context);
        Navigator.popAndPushNamed(context, RouteNames.loginPage);
      });
    }).catchError((e) {
      Navigator.pop(context);
      Dialogs.showMessage(context,
          title:AppTranslations.of(context).text(StringResources.oops ),
          message: e.toString().replaceAll(
              StringResources.exception, StringResources.emptyString),
          onClose: () {
            Navigator.pop(context);
        Navigator.popAndPushNamed(context, RouteNames.loginPage);
      });
    });
  }
}

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
                            title: Text("Choose Source.."),
                            content: Text("how you want to select"),
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
                                  child: Text("CAMERA")),
                              FlatButton(
                                  onPressed: () async {
                                    File file = await ImagePicker.pickImage(
                                        source: ImageSource.gallery);
                                    setState(() {
                                      userImage = file;
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Text("GALLERY"))
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
                        decoration: InputDecoration(
                          labelText: StringResources.doorNo,
                          hasFloatingPlaceholder: true,
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
                          labelText: StringResources.building,
                          hasFloatingPlaceholder: true,
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
                          labelText: StringResources.street,
                          hasFloatingPlaceholder: true,
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
                          labelText: StringResources.city,
                          hasFloatingPlaceholder: true,
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
                          child: Text("Location")),
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
                              child: Text("Select Location"),
                              value: null,
                            ),
                            DropdownMenuItem(
                              child: Text("Ground Floor"),
                              value: "Ground Floor",
                            ),
                            DropdownMenuItem(
                              child: Text("Upstair"),
                              value: "Upstair",
                            ),
                            DropdownMenuItem(
                              child: Text("Seperate House"),
                              value: "Seperate House",
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
          title: StringResources.success,
          message: StringResources.userRegisteredSuccessfully, onClose: () {
        Navigator.pop(context);
        Navigator.popAndPushNamed(context, RouteNames.loginPage);
      });
    }).catchError((e) {
      Navigator.pop(context);
      Dialogs.showMessage(context,
          title: StringResources.oops,
          message: e.toString().replaceAll(
              StringResources.exception, StringResources.emptyString),
          onClose: () {
            Navigator.pop(context);
        Navigator.popAndPushNamed(context, RouteNames.loginPage);
      });
    });
  }
}

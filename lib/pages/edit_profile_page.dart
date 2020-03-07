import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zeroori_customer/bloc/user/bloc.dart';
import 'package:zeroori_customer/bloc/user/user_bloc.dart';
import 'package:zeroori_customer/models/user.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/resources/string_resources.dart';
import 'package:zeroori_customer/resources/style_resources.dart';
import 'package:zeroori_customer/services/user_service.dart';
import 'package:zeroori_customer/utils/dialogs.dart';
import 'package:zeroori_customer/widgets/sign_up_header.dart';

class EditProfilePage extends StatefulWidget {
  final User user;

  EditProfilePage({Key key, this.user}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File userImage;
  TextEditingController nameController;
  TextEditingController countryController;
  TextEditingController addressController;
  TextEditingController zipController;
  UserBloc userBloc;
  TextEditingController doorController;
  TextEditingController buildingController;
  TextEditingController streetController;
  TextEditingController cityController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    countryController = TextEditingController();
    addressController = TextEditingController();
    zipController = TextEditingController();

    doorController = TextEditingController();
    buildingController = TextEditingController();
    streetController = TextEditingController();
    cityController = TextEditingController();

    nameController.text = widget.user?.name;
    countryController.text = widget.user?.country;
    addressController.text = widget.user?.address;
    zipController.text = widget.user?.pincode;
    doorController.text = widget.user?.door;
    buildingController.text = widget.user?.building;
    streetController.text = widget.user?.street;
    cityController.text = widget.user?.city;

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userBloc = BlocProvider.of<UserBloc>(context);
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
                title: "Edit Profile",
                image: widget.user?.profile,
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
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: StringResources.name,
                          hasFloatingPlaceholder: true,
                        ),
                      ),
                      TextFormField(
                        initialValue: widget.user?.phone,
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: StringResources.phone,
                          hasFloatingPlaceholder: true,
                        ),
                      ),
                      TextFormField(
                        initialValue: widget.user?.email,
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: StringResources.email,
                          hasFloatingPlaceholder: true,
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: StringResources.doorNo,
                          hasFloatingPlaceholder: true,
                        ),
                        controller: doorController,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: StringResources.building,
                          hasFloatingPlaceholder: true,
                        ),
                        controller: buildingController,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: StringResources.street,
                          hasFloatingPlaceholder: true,
                        ),
                        controller: streetController,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: StringResources.city,
                          hasFloatingPlaceholder: true,
                        ),
                        controller: cityController,
                      ),
                      TextFormField(
                        controller: addressController,
                        decoration: InputDecoration(
                          labelText: StringResources.addresss,
                          hasFloatingPlaceholder: true,
                        ),
                      ),
                      TextFormField(
                        controller: countryController,
                        decoration: InputDecoration(
                          labelText: StringResources.country,
                          hasFloatingPlaceholder: true,
                        ),
                      ),
                      TextFormField(
                        controller: zipController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: StringResources.postal,
                          hasFloatingPlaceholder: true,
                        ),
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
                              UserService.updateUser({
                                'id': widget.user?.id,
                                'name': nameController.text,
                                'address': addressController.text,
                                'country': countryController.text,
                                'zip': zipController.text,
                                'door': doorController.text,
                                'building': buildingController.text,
                                'street': streetController.text,
                                'city': cityController.text,
                                'image': userImage,
                                'temp': widget.user?.profile
                              }).then((v) {
                                Navigator.pop(context);
                                Dialogs.showMessage(context,
                                    title: "Success",
                                    message: "User updated successfully",
                                    onClose: () async {
                                  Map<String, dynamic> jsonUser =
                                      User.toJson(v);
                                  String us = json.encode(jsonUser).toString();
                                  userBloc.add(UserChanged(v.id, us));
                                  Navigator.pushNamed(
                                      context, RouteNames.servicePage);
                                });
                              }).catchError((e) {
                                Navigator.pop(context);
                                Dialogs.showMessage(context,
                                    title: "Oops!",
                                    message: "Couldn't update user");
                              });
                            },
                            color: ColorResources.primaryColor,
                            child: Text(
                              "Update".toUpperCase(),
                              style: StyleResources.primaryButton(),
                            ),
                          ))
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
}

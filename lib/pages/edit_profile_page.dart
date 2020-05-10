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
import 'package:zeroori_customer/utils/app_translations.dart';
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
  TextEditingController addressController;
  UserBloc userBloc;
  TextEditingController doorController;
  TextEditingController buildingController;
  TextEditingController streetController;
  TextEditingController cityController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    addressController = TextEditingController();

    doorController = TextEditingController();
    buildingController = TextEditingController();
    streetController = TextEditingController();
    cityController = TextEditingController();

    nameController.text = widget.user?.name;
    addressController.text = widget.user?.address;
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
                title: AppTranslations.of(context).text(StringResources.editProfile),
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
                          labelText: AppTranslations.of(context).text(StringResources.name),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                      ),
                      TextFormField(
                        initialValue: widget.user?.phone,
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: AppTranslations.of(context).text(StringResources.phone),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                      ),
                      TextFormField(
                        initialValue: widget.user?.email,
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: AppTranslations.of(context).text(StringResources.email),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: AppTranslations.of(context).text(StringResources.doorNo),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                        controller: doorController,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: AppTranslations.of(context).text(StringResources.building),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                        controller: buildingController,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: AppTranslations.of(context).text(StringResources.street),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                        controller: streetController,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: AppTranslations.of(context).text(StringResources.city),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                        controller: cityController,
                      ),
                      TextFormField(
                        controller: addressController,
                        decoration: InputDecoration(
                          labelText: AppTranslations.of(context).text(StringResources.addresss),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                      ),
//                      TextFormField(
//                        controller: countryController,
//                        decoration: InputDecoration(
//                          labelText: StringResources.country,
//                          hasFloatingPlaceholder: true,
//                        ),
//                      ),
//                      TextFormField(
//                        controller: zipController,
//                        keyboardType: TextInputType.number,
//                        decoration: InputDecoration(
//                          labelText: StringResources.postal,
//                          hasFloatingPlaceholder: true,
//                        ),
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
                              UserService.updateUser({
                                'id': widget.user?.id,
                                'name': nameController.text,
                                'address': addressController.text,
                                'door': doorController.text,
                                'building': buildingController.text,
                                'street': streetController.text,
                                'city': cityController.text,
                                'image': userImage,
                                'temp': widget.user?.profile
                              }).then((v) {
                                Navigator.pop(context);
                                Dialogs.showMessage(context,
                                    title: AppTranslations.of(context).text(StringResources.success),
                                    message: AppTranslations.of(context).text(StringResources.userUpdatedSuccessfully),
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
                                    title: AppTranslations.of(context).text(StringResources.oops),
                                    message: AppTranslations.of(context).text(StringResources.couldntUpdateUser)
                                );
                              });
                            },
                            color: ColorResources.primaryColor,
                            child: Text(
                              AppTranslations.of(context).text(StringResources.update).toUpperCase(),
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

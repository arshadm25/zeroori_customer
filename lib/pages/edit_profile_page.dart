import 'package:flutter/material.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/resources/style_resources.dart';
import 'package:zeroori_customer/widgets/dialogs/message_dialog.dart';
import 'package:zeroori_customer/widgets/sign_up_header.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({Key key}) : super(key: key);


  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

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
                title:"Edit Profile"
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal:24.0),
                child: Form(

                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "First Name",
                          hasFloatingPlaceholder: true,
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Last Name",
                          hasFloatingPlaceholder: true,
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "# Phone",
                          hasFloatingPlaceholder: true,
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Email Address",
                          hasFloatingPlaceholder: true,
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Password",
                          hasFloatingPlaceholder: true,
                        ),
                        obscureText: true,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Address",
                          hasFloatingPlaceholder: true,
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Country",
                          hasFloatingPlaceholder: true,
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Postcode/Zip",
                          hasFloatingPlaceholder: true,
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width/1.5,
                        height: MediaQuery.of(context).size.width/8,
                        child:RaisedButton(
                          onPressed: (){
                            showDialog(context: context,builder: (context){
                              return MessageDialog(
                                title: "Updated",
                                message: "Profile updated successfully",
                                onClose: (){
                                  Navigator.popAndPushNamed(context, 'my_services');
                                },
                              );
                            });
                          },
                          color: ColorResources.primaryColor,
                          child: Text("Update".toUpperCase(),style: StyleResources.primaryButton(),),
                        )
                      )
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

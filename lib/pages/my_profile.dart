import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeroori_customer/bloc/user/bloc.dart';
import 'package:zeroori_customer/models/user.dart';
import 'package:zeroori_customer/pages/BasePage.dart';
import 'package:zeroori_customer/pages/edit_profile_page.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/resources/string_resources.dart';
import 'package:zeroori_customer/widgets/dialogs/message_dialog.dart';

class MyProfilePage extends StatefulWidget {
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is LoggedInState) {
          return _generatePage(
            user: User.fromSharePref(
              json.decode(state.user),
            ),
          );
        }
        return _generatePage();
      },
    );
  }

  _generatePage({User user}) {
    return BasePage(
      title: "My Profile",
      hasBack: true,
      trailing: IconButton(
        icon: Icon(
          Icons.notifications,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.popAndPushNamed(context, 'notification');
        },
      ),
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 25,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 5,
                      height: MediaQuery.of(context).size.width / 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: ColorResources.primaryColor,
                          width: 2,
                        ),
                      ),
                      child: FadeInImage.assetNetwork(
                        placeholder: "assets/user.png",
                        image: UrlResources.mainUrl + user.profile,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              user.name ?? "Username",
                              style: Theme.of(context)
                                  .textTheme
                                  .title
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditProfilePage(
                                      user: user,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorResources.primaryColor,
                                ),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.credit_card,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              user.id.toString() ?? "12345",
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(
                              Icons.check,
                              color: Colors.grey,
                              size: 20,
                            ),
                            Text(
                              "Completed Request: ${user.noOfJobs ?? 0}",
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: <Widget>[
                    _generateListTile("Edit Profile", Icons.edit,
                        onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfilePage(
                            user: user,
                          ),
                        ),
                      );
                    }),
                    _generateListTile("Language Settings", Icons.language,
                        onPressed: () {
                      Navigator.pushNamed(context, 'language');
                    }),
                    _generateListTile("Email Us", Icons.mail, onPressed: () {
                      Navigator.pushNamed(context, 'email');
                    }),
                    _generateListTile("About Zeroori Services", Icons.help,
                        onPressed: () {
                      Navigator.pushNamed(context, 'about');
                    }),
                    user != null
                        ? _generateListTile("Logout", Icons.settings_power,
                            onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return MessageDialog(
                                    title: "Success",
                                    message: "You have logged Out Successfully",
                                    onClose: () {
                                      Navigator.popAndPushNamed(
                                          context, 'front_page');
                                    },
                                  );
                                });
                          })
                        : _generateListTile("Login", Icons.settings_power,
                            onPressed: () {
                            Navigator.pushNamed(context, 'login');
                          }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _generateListTile(String text, IconData leading, {VoidCallback onPressed}) {
    return ListTile(
      leading: Icon(
        leading,
        color: Colors.black87,
      ),
      title: Text(
        text,
        style: TextStyle(color: Colors.black, fontSize: 18),
      ),
      trailing: Icon(Icons.arrow_forward, color: Colors.black87),
      onTap: onPressed,
    );
  }
}

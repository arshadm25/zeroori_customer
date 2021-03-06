import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeroori_customer/bloc/user/bloc.dart';
import 'package:zeroori_customer/models/user.dart';
import 'package:zeroori_customer/pages/BasePage.dart';
import 'package:zeroori_customer/pages/edit_profile_page.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/resources/string_resources.dart';
import 'package:zeroori_customer/utils/app_translations.dart';
import 'package:zeroori_customer/widgets/dialogs/message_dialog.dart';

class MyProfilePage extends StatefulWidget {
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  UserBloc userBloc;

  @override
  didChangeDependencies(){
    super.didChangeDependencies();
    userBloc = BlocProvider.of<UserBloc>(context);
    userBloc.add(AppInitial());
  }

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
      title: AppTranslations.of(context).text(StringResources.my_profile),
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
                                  .headline6
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
                              user.id.toString() ?? "N/A",
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
                              AppTranslations.of(context).text(StringResources.completed_request)+" ${user.noOfJobs ?? 0}",
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
                    _generateListTile(AppTranslations.of(context).text(StringResources.editProfile), Icons.edit,
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
                    _generateListTile(AppTranslations.of(context).text(StringResources.language_settings), Icons.language,
                        onPressed: () {
                      Navigator.pushNamed(context, 'language');
                    }),
                    _generateListTile(AppTranslations.of(context).text(StringResources.mail_us), Icons.mail, onPressed: () {
                      Navigator.pushNamed(context, 'email');
                    }),
                    _generateListTile(AppTranslations.of(context).text(StringResources.about_zeroori_service), Icons.help,
                        onPressed: () {
                      Navigator.pushNamed(context, 'about');
                    }),
                    user != null
                        ? _generateListTile(AppTranslations.of(context).text(StringResources.logout), Icons.settings_power,
                            onPressed: () {
                            userBloc.add(LogOut());
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return MessageDialog(
                                    title: AppTranslations.of(context).text(StringResources.success),
                                    message: AppTranslations.of(context).text(StringResources.logout_success),
                                    onClose: () {
                                      Navigator.pop(context);
                                      Navigator.popAndPushNamed(
                                          context, 'front_page');
                                    },
                                  );
                                });

                          })
                        : _generateListTile(AppTranslations.of(context).text(StringResources.login), Icons.settings_power,
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

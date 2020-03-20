import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeroori_customer/bloc/user/bloc.dart';
import 'package:zeroori_customer/models/area.dart';
import 'package:zeroori_customer/models/user.dart';
import 'package:zeroori_customer/pages/BasePage.dart';
import 'package:zeroori_customer/pages/describe_problem_page.dart';
import 'package:zeroori_customer/pages/sign_in_page.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/resources/string_resources.dart';
import 'package:zeroori_customer/resources/style_resources.dart';
import 'package:zeroori_customer/utils/app_translations.dart';
import 'package:zeroori_customer/utils/dialogs.dart';

class MapSelectionPage extends StatefulWidget {
  final int service;
  final int subCategory;
  final Area area;

  const MapSelectionPage({Key key, this.area, this.service, this.subCategory})
      : super(key: key);

  @override
  _MapSelectionPageState createState() => _MapSelectionPageState();
}

class _MapSelectionPageState extends State<MapSelectionPage> {
  TextEditingController addressController;
  UserBloc userBloc;
  bool isOldAddress = false;

  @override
  void initState() {
    super.initState();
    addressController = TextEditingController();
    isOldAddress = false;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userBloc = BlocProvider.of<UserBloc>(context);
    userBloc.add(AppInitial());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is LoggedInState) {
          return _generateBuild(
              user: User.fromSharePref(json.decode(state.user)));
        }
        return SignInPage();
      },
    );
  }

  _generateBuild({User user}) {
    return BasePage(
        customTitle: Column(
          children: <Widget>[
            Text(AppTranslations.of(context).text(StringResources.completed_40),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                )),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: LinearProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      ColorResources.proggressBarColor),
                  value: 0.4),
            ),
          ],
        ),
        hasBack: true,
        trailing: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(3, 3),
                                color: Colors.grey.withOpacity(0.5))
                          ]),
                      height: (MediaQuery.of(context).size.height / 2.5),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                AppTranslations.of(context).text(StringResources.pleaseEnterAddress),
                                style: Theme.of(context).textTheme.headline,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                maxLines: 5,
                                decoration: InputDecoration(
                                  labelText:AppTranslations.of(context).text(StringResources.enter_your_address_here),
                                  hasFloatingPlaceholder: true,
                                ),
                                controller: addressController,
                              ),
                              SizedBox(height: 5),
                              Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Checkbox(
                                      value: isOldAddress,
                                      onChanged: (val) {
                                        setState(() {
                                          isOldAddress = val;
                                          if(val){
                                            addressController.text = user.door + "\n" + user.building + "\n"
                                              + user.street + "\n" + user.city ;
                                          }else{
                                            addressController.text = "";
                                          }

                                        });
                                      },
                                    ),
                                    SizedBox(width: 15),
                                    Text(
                                      AppTranslations.of(context).text(StringResources.use_my_profile_address),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ])
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 25.0),
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 75,
                        height: 60,
                        child: RaisedButton(
                          color: ColorResources.primaryColor,
                          child: Text(
                            AppTranslations.of(context).text(StringResources.next),
                            style: StyleResources.primaryButton(),
                          ),
                          onPressed: () {
                            Dialogs.showLoader(context);
                            if (addressController.text.isEmpty) {
                              Navigator.pop(context);
                              Dialogs.showMessage(context,
                                  title: AppTranslations.of(context).text(StringResources.success),
                                  message: AppTranslations.of(context).text(StringResources.please_enter_valid_address));
                            } else {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DescribeProblemPage(
                                    service: widget.service,
                                    subCategory: widget.subCategory,
                                    area: widget.area,
                                    address: addressController.text,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}

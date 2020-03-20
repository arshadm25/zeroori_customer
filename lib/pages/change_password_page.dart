import 'package:flutter/material.dart';
import 'package:zeroori_customer/pages/BasePage.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/resources/string_resources.dart';
import 'package:zeroori_customer/utils/app_translations.dart';
import 'package:zeroori_customer/widgets/dialogs/message_dialog.dart';

class ChangePassworedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title:AppTranslations.of(context).text(StringResources.changePassword),
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
                            AppTranslations.of(context).text(StringResources.changePassword),
                            style: Theme.of(context).textTheme.headline,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Form(
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: AppTranslations.of(context).text(StringResources.currentPassword),
                                    hasFloatingPlaceholder: true,
                                  ),
                                  obscureText: true,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: AppTranslations.of(context).text(StringResources.newPassword),
                                    hasFloatingPlaceholder: true,
                                  ),
                                  obscureText: true,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText:AppTranslations.of(context).text(StringResources.confirmPassword),
                                    hasFloatingPlaceholder: true,
                                  ),
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
                    AppTranslations.of(context).text(StringResources.submit).toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return MessageDialog(
                            title: AppTranslations.of(context).text(StringResources.success),
                            message: AppTranslations.of(context).text(StringResources.passwordChangedSuccessfully),
                            onClose: () {
                              Navigator.popAndPushNamed(context, 'login');
                            },
                          );
                        });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

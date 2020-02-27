import 'package:flutter/material.dart';
import 'package:zeroori_customer/pages/BasePage.dart';
import 'package:zeroori_customer/resources/color_resources.dart';

class ForgotPassworedPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Forgot Password",
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
                            "Forgot Password",
                            style: Theme.of(context).textTheme.headline,
                          ),
                          Text(
                            "Enter email to continue",
                            style: Theme.of(context).textTheme.caption,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Form(
                            child: Column(
                              children: <Widget>[

                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "Email",
                                    hasFloatingPlaceholder: true,
                                  ),
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
                    "Submit".toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, 'change_password');
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

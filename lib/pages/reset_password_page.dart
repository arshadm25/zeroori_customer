import 'package:flutter/material.dart';
import 'package:zeroori_customer/pages/BasePage.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/resources/string_resources.dart';
import 'package:zeroori_customer/services/login_service.dart';
import 'package:zeroori_customer/utils/dialogs.dart';

class ResetPasswordPage extends StatefulWidget {
  final String email;

  const ResetPasswordPage({Key key, this.email}) : super(key: key);
  
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController newPasswordController;
  TextEditingController confirmPasswordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: StringResources.resetPassword,
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
                            StringResources.resetPassword,
                            style: Theme.of(context).textTheme.headline,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: StringResources.newPassword,
                                    hasFloatingPlaceholder: true,
                                  ),
                                  validator: (val){
                                    if(val.isEmpty){
                                      return StringResources.pleaseEnterValidPassword;
                                    }
                                    if(val.length<8){
                                      return StringResources.pleaseEnterPasswordMinimum8;
                                    }
                                    return null;
                                  },
                                  controller: newPasswordController,
                                  obscureText: true,
                                ),

                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: StringResources.confirmPassword,
                                    hasFloatingPlaceholder: true,
                                  ),
                                  validator: (val){
                                    if(val.isEmpty){
                                      return StringResources.pleaseEnterValidPassword;
                                    }
                                    if(val.length<8){
                                      return StringResources.pleaseEnterPasswordMinimum8;
                                    }
                                    if(val != newPasswordController.text){
                                      return StringResources.passwordConfirmPasswordMismatch;
                                    }
                                    return null;
                                  },
                                  controller: confirmPasswordController,
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
                    StringResources.submit.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () {
                    if(_formKey.currentState.validate()){
                      _onPasswordReset();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onPasswordReset(){
    LoginServices.resetPassword(newPasswordController.text,widget.email).then((s){
      Dialogs.showMessage(context,title: StringResources.success,message: s,onClose: (){
        Navigator.pushNamed(context, RouteNames.loginPage);
      });
    }).catchError((e){
      Dialogs.showMessage(context,title: StringResources.oops,message: e.toString().replaceAll(StringResources.exception, StringResources.emptyString,),);
    });
  }
}

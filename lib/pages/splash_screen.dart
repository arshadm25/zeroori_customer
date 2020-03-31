import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zeroori_customer/pages/select_language_page.dart';
import 'package:zeroori_customer/resources/image_resources.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((res) {

      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context)=>SelectLanguagePage(
          hasBack: false,
        )
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor:ColorResources.primaryColor,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width / 3,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Image.asset(ImageResources.logo),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

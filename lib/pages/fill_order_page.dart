import 'package:flutter/material.dart';
import 'package:zeroori_customer/pages/BasePage.dart';
import 'package:zeroori_customer/resources/color_resources.dart';

class FillOrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Fill Order",
      hasBack: true,
      trailing: IconButton(
        icon: Icon(Icons.close,color: Colors.white,),
        onPressed: (){
          Navigator.pop(context);
        },
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/chat_bubble.png",color: ColorResources.primaryColor,width: MediaQuery.of(context).size.width/2,fit: BoxFit.contain,),
//            Icon(Icons.chat,size: 100,color: ColorResources.primaryColor,),
            Text("We Will Ask you few questions to collect the required details for your order to send it to agents",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 25
            ),),
            SizedBox(
              height:60,
              width: MediaQuery.of(context).size.width-75,
              child: RaisedButton(
                color: ColorResources.primaryColor,
                onPressed: (){
                  Navigator.pushNamed(context, 'select_area');
                },
                child: Text("Get Started".toUpperCase(),style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),),
              ),
            )
          ],
        ),
      ),
    );
  }
}

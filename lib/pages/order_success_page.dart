import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/resources/style_resources.dart';

class OrderSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Color(0x8D1B3D).withOpacity(1),
          title: Text("Order Success")),
      backgroundColor: ColorResources.secondaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height / 2,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Icon(
                        Icons.local_offer,
                        color: ColorResources.primaryColor,
                        size: 50,
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24.0,
                        ),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "20% ",
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: "Discount\n",
                                style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: "on\nExtra Service",
                                style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          maxLines: 3,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: RaisedButton(
                        elevation: 8.0,
                        onPressed: () {},
                        color: ColorResources.primaryColor,
                        child: Text(
                          "Book Now",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.insert_drive_file,size: 30,),
                          SizedBox(width:25),
                          Text("Terms and Conditions",style: TextStyle(
                            fontSize: 25,
                          ),),
                        ],
                      ),
                      SizedBox(height: 25,),
                      _generateLitTile(context,"You will recieve offers on the required service within 30 minutes from now"),
                      _generateLitTile(context,"Price in offers could change in case description of order not clear or additional work required"),
                      _generateLitTile(context,"In Case you face any issue with service provider, you can contact us directly via the chat service in the application or "),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal:8.0),
                        width: MediaQuery.of(context).size.width-50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Container(width:10,height: 10,),
                            SizedBox(width:25),
                            Container(
                              width: MediaQuery.of(context).size.width-150,
                              child: Text.rich(TextSpan(
                                children:[
                                  TextSpan(
                                    text:"Email: ",
                                    style: TextStyle(
                                      color: Color(0x6C6E6D).withOpacity(1),
                                    )
                                  ),
                                  TextSpan(
                                    text:"Support@demo.com",
                                    style: TextStyle(
                                      color: ColorResources.primaryColor,
                                      fontWeight: FontWeight.bold
                                    )
                                  )
                                ]
                              ),maxLines:5,style: TextStyle(
                                fontSize: 15,
                              ),),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:24.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height:60,
                          child:RaisedButton(
                            color: ColorResources.primaryColor,
                            onPressed: (){

                            },
                            child:Text("Done",style: StyleResources.primaryButton(),)
                          )
                        ),
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

  _generateLitTile(context,content){
    return Container(
      padding: EdgeInsets.all(8.0),
      width: MediaQuery.of(context).size.width-50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(width:10,height: 10,decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black,
          ),),
          SizedBox(width:25),
          Container(
            width: MediaQuery.of(context).size.width-150,
            child: Text(content,maxLines:5,style: TextStyle(
              fontSize: 15,
              color: Color(0x6C6E6D).withOpacity(1),
            ),),
          ),
        ],
      ),
    );
  }
}

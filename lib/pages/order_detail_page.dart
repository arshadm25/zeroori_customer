import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zeroori_customer/models/order.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/widgets/dialogs/message_dialog.dart';
import 'package:zeroori_customer/widgets/order_detail_image.dart';

class OrderDetailPage extends StatelessWidget {
  final Order order;

  const OrderDetailPage({Key key, this.order}) : super(key: key);

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
        title: Text("Order Details Page"),
        actions: <Widget>[Icon(Icons.notifications)],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Order Detail",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        RaisedButton(
                          color: ColorResources.primaryColor,
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                              side: BorderSide(
                                color: Colors.white,
                              )),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        RaisedButton(
                          color: Colors.white,
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                              side: BorderSide(
                                color: ColorResources.primaryColor,
                              )),
                          child: Text(
                            "Share",
                            style: TextStyle(
                              color: ColorResources.primaryColor,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(
                  thickness: 8,
                  color: ColorResources.secondaryColor,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    OrderDetailImage(),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            order.service.name,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(Icons.calendar_today, color: Colors.grey),
                              SizedBox(width: 5),
                              Text(
                                order.estimatedDate,
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(Icons.local_offer, color: Colors.grey),
                              SizedBox(width: 5),
                              Text.rich(
                                TextSpan(children: [
                                  TextSpan(text: "Status: "),
                                  TextSpan(
                                      text: order.status,
                                      style: TextStyle(
                                        color: ColorResources.primaryColor,
                                      ))
                                ]),
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              "#${order.id}",
                              style: TextStyle(
                                color: ColorResources.primaryColor,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "Order Id",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Divider(
                  height: 10,
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Service Provider need to visit the location first to give final price",
                  style: TextStyle(
                    color: ColorResources.primaryColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(
                  thickness: 8,
                  height: 25,
                  color: ColorResources.secondaryColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Area",
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    Text(
                      order.area,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(
                  thickness: 8,
                  height: 25,
                  color: ColorResources.secondaryColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Location",
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    Text(
                      order.location,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(
                  thickness: 8,
                  height: 25,
                  color: ColorResources.secondaryColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Preffered Time",
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    Text(
                      order.prefferedTime,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(
                  thickness: 8,
                  height: 25,
                  color: ColorResources.secondaryColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Description",
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                      Text(
                        order.description,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(
                  thickness: 8,
                  height: 25,
                  color: ColorResources.secondaryColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Type Of Service",
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    Text(
                      order.typeOfService,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(
                  thickness: 8,
                  height: 25,
                  color: ColorResources.secondaryColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Unit Type",
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    Text(
                      order.unitType,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(
                  thickness: 8,
                  height: 25,
                  color: ColorResources.secondaryColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "000974568234",
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    RaisedButton(
                      color: ColorResources.primaryColor,
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          side: BorderSide(
                            color: Colors.white,
                          )),
                      child: Text(
                        "CALL",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(
                  thickness: 8,
                  height: 25,
                  color: ColorResources.secondaryColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Attached Photos",
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: <Widget>[
                          _generateImageWidget(),
                          _generateImageWidget(),
                          _generateImageWidget(),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:24.0),
                child: Container(
                  width:MediaQuery.of(context).size.width,
                  height:MediaQuery.of(context).size.height/3,
                  color: Colors.black12,
                  child:Image.asset("assets/map1.png",fit: BoxFit.cover,)
                ),
              ),
              SizedBox(height: 25),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _generateBottomButtons(context,Icons.business_center,"View Offer",onPressed: (){
                    Navigator.pushNamed(context, 'offer');
                  }),
                  _generateBottomButtons(context,Icons.flag,"Report",onPressed: (){
                    Navigator.pushNamed(context, 'report');
                  }),
                  _generateBottomButtons(context,Icons.check,"End Order",onPressed: (){
                    showDialog(context: context,builder: (context){
                      return MessageDialog(
                        title: "Sucess",
                        message: "Order has been ended Successfully",
                        onClose: (){
                          Navigator.pop(context);
                        },
                      );
                    });
                  }),
                ],
              ),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  _generateImageWidget(){
    return Padding(
      padding: const EdgeInsets.only(right:8.0),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child:ClipRRect(borderRadius: BorderRadius.circular(5.0),child: Image.asset("assets/wood.jpg",fit: BoxFit.cover,)),
      ),
    );
  }

  _generateBottomButtons(context,iconData,text,{VoidCallback onPressed}){
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width/4,
        height: MediaQuery.of(context).size.width/8,
        child: Column(
          children: <Widget>[
            Icon(iconData,color: Colors.black54,),
            Text(text,style: TextStyle(
              color: Colors.black54
            ),)
          ],
        ),
      ),
    );
  }
}

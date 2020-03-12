import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zeroori_customer/models/order.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/resources/string_resources.dart';
import 'package:zeroori_customer/services/order_services.dart';
import 'package:zeroori_customer/utils/dialogs.dart';
import 'package:zeroori_customer/widgets/dialogs/rating_dialog.dart';
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
                          onPressed: () {
                            Dialogs.showLoader(context);
                            OrderService.completeorCancelOrder(
                                    order.id, OrderStatus.CANCELLED)
                                .then((v) {
                              Navigator.pop(context);
                              Dialogs.showMessage(context,
                                  title: "Success",
                                  message: "Order cancelled successfully",
                                  onClose: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              });
                            }).catchError((e) {
                              Navigator.pop(context);
                              Dialogs.showMessage(context,
                                  title: "Oops!", message: e.toString());
                            });
                          },
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
                    OrderDetailImage(
                      image:"",
                      onCalled: () async {
                        var url = 'tel:${order.providerPhone}';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          Dialogs.showMessage(
                            context,
                            title: "Error",
                            message: "Couldn't make call",
                          );
                        }
                      },
                    ),
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
                                order.prefferedTime,
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
                                      text: StatusConverter()
                                          .getStatus(order.status),
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
                      "Address",
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    Text(
                      order.address ?? "N/A",
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
              Visibility(
                visible:order.status == OrderStatus.IN_PROGRESS || order.status == OrderStatus.COMPLETED,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        order.providerPhone ?? "N/A",
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                      RaisedButton(
                        color: ColorResources.primaryColor,
                        onPressed: () async {
                          var url = 'tel:${order.providerPhone}';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            Dialogs.showMessage(
                              context,
                              title: "Error",
                              message: "Couldn't make call",
                            );
                          }
                        },
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
                      order.images != null
                          ? Row(
                              children:
                                  List.generate(order.images?.length, (index) {
                              return _generateImageWidget(
                                  order.images[index]['vchr_job_image']);
                            }) //.map((i)=>_generateImageWidget(i)).toList(),
                              )
                          : Container(width: 0, height: 0)
                    ],
                  ),
                ),
              ),
//              SizedBox(height: 10),
//              Padding(
//                padding: const EdgeInsets.symmetric(horizontal:24.0),
//                child: Container(
//                  width:MediaQuery.of(context).size.width,
//                  height:MediaQuery.of(context).size.height/3,
//                  color: Colors.black12,
//                  child:Image.asset("assets/map1.png",fit: BoxFit.cover,)
//                ),
//              ),
              SizedBox(height: 25),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _generateBottomButtons(
                      context, Icons.business_center, "View Offer",
                      onPressed: () {
                    Navigator.pushNamed(context, 'offer');
                  }),
                  _generateBottomButtons(context, Icons.flag, "Report",
                      onPressed: () {
                    Navigator.pushNamed(context, 'report');
                  }),
                  Visibility(
                    visible: order.status != OrderStatus.IN_PROGRESS &&
                        order.status != OrderStatus.COMPLETED &&
                      order.status != OrderStatus.CANCELLED,
                    child: _generateBottomButtons(
                        context, Icons.check, "End Order", onPressed: () {
                      Dialogs.showLoader(context);
                      OrderService.completeorCancelOrder(
                              order.id, OrderStatus.COMPLETED)
                          .then((v) {
                        Navigator.pop(context);
                        Dialogs.showMessage(context,
                            title: "Success",
                            message: "Order completed successfully",
                            onClose: () {
                              showDialog(
                                  context:context,
                                  builder: (context){
                                    return RatingDialog(
                                      onRatingCompleted: (rating,description){
                                        Dialogs.showLoader(context);
                                        OrderService.rateNow({
                                          'job': order.id,
                                          'rating': rating,
                                          'description': description,
                                        }).then((s){
                                          Navigator.pop(context);
                                          Dialogs.showMessage(context,title:"Sucess",message: "Your rating added successfully",onClose:(){
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          });
                                        }).catchError((e){
                                          Navigator.pop(context);
                                          Dialogs.showMessage(context,title:"Oops!",message: "Sorry couldn't add rating",onClose:(){
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          });
                                        });
                                      },
                                    );
                                  }
                              );
                          Navigator.pop(context);
                          Navigator.pop(context);
                        });
                      }).catchError((e) {
                        Navigator.pop(context);
                        Dialogs.showMessage(context,
                            title: "Oops!", message: e.toString());
                      });
                    }),
                  )
                ],
              ),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  _generateImageWidget(String image) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: FadeInImage.assetNetwork(
              placeholder: "assets/wood.jpg",
              image: UrlResources.mainUrl + image,
              fit: BoxFit.cover,
            )),
      ),
    );
  }

  _generateBottomButtons(context, iconData, text, {VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width / 4,
        height: MediaQuery.of(context).size.width / 8,
        child: Column(
          children: <Widget>[
            Icon(
              iconData,
              color: Colors.black54,
            ),
            Text(
              text,
              style: TextStyle(color: Colors.black54),
            )
          ],
        ),
      ),
    );
  }
}

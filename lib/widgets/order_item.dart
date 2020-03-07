import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zeroori_customer/models/order.dart';
import 'package:zeroori_customer/pages/order_detail_page.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/resources/string_resources.dart';
import 'package:zeroori_customer/services/order_services.dart';
import 'package:zeroori_customer/utils/dialogs.dart';

class OrderItem extends StatelessWidget {
  final Order order;
  final VoidCallback onOrderChagned;

  const OrderItem({Key key, this.order, this.onOrderChagned}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 5,
                    height: MediaQuery.of(context).size.width / 5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: ColorResources.primaryColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: FadeInImage.assetNetwork(
                      placeholder: "assets/ac.jpg",
                      image: UrlResources.mainUrl +
                          ((order.images != null && order.images.length > 0)
                              ? order.images[0]['vchr_job_image']
                              : ''),
                      fit: BoxFit.cover,
                    ),
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
                                    text:
                                        '${StatusConverter().getStatus(order.status)}',
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
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(
                color: ColorResources.primaryColor,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    order.description ?? "Description",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  )),
            ),
            SizedBox(
              height: 5,
            ),
            Visibility(
              visible: order.status != OrderStatus.PROCESSING &&
                  order.status != OrderStatus.COMPLETED,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(
                  color: ColorResources.primaryColor,
                ),
              ),
            ),
            Visibility(
              visible: order.status != OrderStatus.PROCESSING &&
                  order.status != OrderStatus.COMPLETED,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Does this service completed successfully",
                        style: TextStyle(
                            color: ColorResources.primaryColor, fontSize: 18),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        _generateAccetpTile(
                            Icons.check, ColorResources.primaryColor,
                            onPressed: () {
                          Dialogs.showLoader(context);
                          OrderService.completeorCancelOrder(
                                  order.id, OrderStatus.COMPLETED)
                              .then((v) {
                            Navigator.pop(context);
                            Dialogs.showMessage(context,
                                title: "Success",
                                message: "Order confirmed successfully",
                                onClose: this.onOrderChagned);
                          }).catchError((e) {
                            Navigator.pop(context);
                            Dialogs.showMessage(
                              context,
                              title: "Oops!",
                              message: e.toString(),
                            );
                          });
                        }),
                        SizedBox(
                          width: 10,
                        ),
                        _generateAccetpTile(Icons.clear, Colors.grey,
                            onPressed: () {
                          Dialogs.showLoader(context);
                          OrderService.completeorCancelOrder(
                                  order.id, OrderStatus.CANCELLED)
                              .then((v) {
                            Navigator.pop(context);
                            Dialogs.showMessage(context,
                                title: "Success",
                                message: "Order Accepted successfully",
                                onClose: this.onOrderChagned);
                          }).catchError((e) {
                            Navigator.pop(context);
                            Dialogs.showMessage(context,
                                title: "Oops!", message: e.toString());
                          });
                        }),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _generateBottomTile(
                    context,
                    Icons.layers,
                    "Order Details",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderDetailPage(
                                  order: order,
                                )),
                      );
                    },
                  ),
                  _generateBottomTile(context, Icons.info, "Report",
                      onPressed: () {
                    Navigator.pushNamed(context, 'report');
                  }),
                  Visibility(
                    visible: order.status != OrderStatus.PROCESSING,
                    child: _generateBottomTile(
                        context, Icons.clear, "Cancel Request", onPressed: () {
                      Dialogs.showLoader(context);
                      OrderService.completeorCancelOrder(
                              order.id, OrderStatus.CANCELLED)
                          .then((v) {
                        Navigator.pop(context);
                        Dialogs.showMessage(context,
                            title: "Success",
                            message: "Order cancelled successfully",
                            onClose: this.onOrderChagned);
                      }).catchError((e) {
                        Navigator.pop(context);
                        Dialogs.showMessage(context,
                            title: "Oops!", message: e.toString());
                      });
                    }),
                  )
                ])
          ],
        ));
  }

  _generateBottomTile(context, icon, text, {VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: order.status != OrderStatus.PROCESSING
            ? MediaQuery.of(context).size.width / 3
            : MediaQuery.of(context).size.width / 2,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: ColorResources.orderItemBottomButtonColor,
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
        ),
        child: Row(
          children: <Widget>[
            Icon(icon, color: ColorResources.primaryColor),
            SizedBox(width: 5),
            Text(
              text,
              style: TextStyle(
                fontSize: 12,
                color: ColorResources.primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }

  _generateAccetpTile(icon, color, {VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}

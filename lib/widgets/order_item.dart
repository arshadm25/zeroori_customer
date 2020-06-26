import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zeroori_customer/models/order.dart';
import 'package:zeroori_customer/pages/order_detail_page.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/resources/string_resources.dart';
import 'package:zeroori_customer/services/order_services.dart';
import 'package:zeroori_customer/utils/app_translations.dart';
import 'package:zeroori_customer/utils/dialogs.dart';
import 'package:zeroori_customer/widgets/dialogs/rating_dialog.dart';

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
                            fontSize: 20,
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
                                TextSpan(text:AppTranslations.of(context).text(StringResources.status)),
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
                          FittedBox(
                            child: Text(
                              AppTranslations.of(context).text(StringResources.order_id),
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
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
                    order.description ??AppTranslations.of(context).text(StringResources.description),
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
                  order.status != OrderStatus.COMPLETED &&
                  order.status != OrderStatus.CANCELLED,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(
                  color: ColorResources.primaryColor,
                ),
              ),
            ),
            Visibility(
              visible: order.status != OrderStatus.PROCESSING &&
                  order.status != OrderStatus.COMPLETED &&
                order.status != OrderStatus.CANCELLED,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        AppTranslations.of(context).text(StringResources.does_this_service_completed),
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
                                title: AppTranslations.of(context).text(StringResources.success),
                                message:AppTranslations.of(context).text(StringResources.order_completed_success),
                                onClose: (){
                              this.onOrderChagned();
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
                                          Dialogs.showMessage(context,title:AppTranslations.of(context).text(StringResources.success),message: AppTranslations.of(context).text(StringResources.your_rating_added_succesfully),onClose:(){
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          });
                                        }).catchError((e){
                                          Navigator.pop(context);
                                          Dialogs.showMessage(context,title:AppTranslations.of(context).text(StringResources.oops),message:AppTranslations.of(context).text(StringResources.couldnt_add_rating),onClose:(){
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          });
                                        });
//                                    Navigator.pop(context);
                                      },
                                    );
                                  }
                              );
                            });

                          }).catchError((e) {
                            Navigator.pop(context);
                            Dialogs.showMessage(
                              context,
                              title: AppTranslations.of(context).text(StringResources.oops),
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
                                title: AppTranslations.of(context).text(StringResources.success),
                                message: AppTranslations.of(context).text(StringResources.order_accepted_successfully),
                                onClose: this.onOrderChagned);
                          }).catchError((e) {
                            Navigator.pop(context);
                            Dialogs.showMessage(context,
                                title: AppTranslations.of(context).text(StringResources.oops), message: e.toString());
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
                  Expanded(
                    flex:1,
                    child:_generateBottomTile(
                      context,
                      Icons.layers,
                      AppTranslations.of(context).text(StringResources.order_detail),
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
                  ),
                  Expanded(
                    flex:1,
                    child:_generateBottomTile(context, Icons.info, AppTranslations.of(context).text(StringResources.report),
                        onPressed: () {
                          Navigator.pushNamed(context, 'report');
                        })
                  ),
                  Visibility(
                    visible: order.status != OrderStatus.PROCESSING && order.status != OrderStatus.CANCELLED
                    && order.status != OrderStatus.COMPLETED,
                    child: Expanded(
                      flex: 1,
                      child: _generateBottomTile(
                          context, Icons.clear, AppTranslations.of(context).text(StringResources.cancel_request), onPressed: () {
                        Dialogs.showLoader(context);
                        OrderService.completeorCancelOrder(
                                order.id, OrderStatus.CANCELLED)
                            .then((v) {
                          Navigator.pop(context);
                          Dialogs.showMessage(context,
                              title: AppTranslations.of(context).text(StringResources.success),
                              message: AppTranslations.of(context).text(StringResources.order_cancelled_success),
                              onClose: this.onOrderChagned);
                        }).catchError((e) {
                          Navigator.pop(context);
                          Dialogs.showMessage(context,
                              title: AppTranslations.of(context).text(StringResources.oops), message: e.toString());
                        });
                      }),
                    ),
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

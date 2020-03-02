import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zeroori_customer/models/area.dart';
import 'package:zeroori_customer/pages/BasePage.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/resources/string_resources.dart';
import 'package:zeroori_customer/resources/style_resources.dart';
import 'package:zeroori_customer/services/order_services.dart';
import 'package:zeroori_customer/utils/dialogs.dart';

class ConfirmPage extends StatefulWidget {
  final int service;
  final int subCategory;
  final Area area;
  final String address;
  final String problem;
  final String time;
  final List<File> images;

  const ConfirmPage({Key key, this.area, this.address, this.problem, this.time, this.images, this.service, this.subCategory}) : super(key: key);

  @override
  _ConfirmPageState createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  TextEditingController areaController;
  TextEditingController locationController;
  TextEditingController descriptionController;
  TextEditingController timeController;

  @override
  void initState() {
    super.initState();
    areaController = TextEditingController();
    locationController = TextEditingController();
    descriptionController = TextEditingController();
    timeController = TextEditingController();
    areaController.text = widget.area.name;
    locationController.text = widget.address;
    descriptionController.text = widget.problem;
    timeController.text = widget.time;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return BasePage(
      customTitle:Column(
        children: <Widget>[
          Text("Completed 100%",style:TextStyle(
            color: Colors.white,
            fontSize:12,
          )),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            width:MediaQuery.of(context).size.width/2,
            child: LinearProgressIndicator(
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(ColorResources.proggressBarColor),
              value: 1,
            ),
          ),
        ],
      ),
      hasBack: true,
      trailing: IconButton(
        icon: Icon(Icons.close,color: Colors.white,),
        onPressed: (){
          Navigator.pop(context);
        },
      ),
      child: Form(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Area",
                        hasFloatingPlaceholder: true,
                      ),
                      enabled: false,
                      readOnly: true,
                      controller: areaController,
                    ),
                    TextFormField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: "Location",
                        hasFloatingPlaceholder: true,
                      ),
                      controller: locationController,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "Request Description",
                          hasFloatingPlaceholder: true
                      ),
                      maxLines: 5,
                      controller: descriptionController,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "Preffered Time",
                          hasFloatingPlaceholder: true
                      ),
                      controller: timeController,
                    ),
                  ],
                ),
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width-75,
                  height: 60,
                  child:RaisedButton(
                    onPressed: () async {
                      _onConfirm();
                    },
                    color: ColorResources.primaryColor,
                    child: Text("Confirm and Send",style: StyleResources.primaryButton(),),
                  )
              ),
              SizedBox(height: 15,)
            ],
          ),
        ),
      ),
    );
  }

  _onConfirm() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int userId = preferences.getInt(SharedResources.USER_ID);
    OrderService.createOrder(userId, {
      'area': widget.area,
      'address': widget.address,
      'problem': widget.problem,
      'images': widget.images,
      'service':widget.service,
      'sub_category':widget.subCategory,
      'time': widget.time,
    }).then((v){
      Dialogs.showMessage(context,title: StringResources.success,message: "Our representative will contact you soon",onClose: (){
        Navigator.pushNamed(context, RouteNames.myOrdersPage);
      });
    }).catchError((e){
      Dialogs.showMessage(context,title: "Error",message: e.toString().replaceAll(StringResources.exception, StringResources.emptyString),);
    });
  }
}

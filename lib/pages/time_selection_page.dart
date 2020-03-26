import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:zeroori_customer/models/area.dart';
import 'package:zeroori_customer/pages/BasePage.dart';
import 'package:zeroori_customer/pages/image_page.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/resources/string_resources.dart';
import 'package:zeroori_customer/resources/style_resources.dart';
import 'package:zeroori_customer/utils/app_translations.dart';

enum DateSelector { TODAY, TOMORROW, CALENDER }

class TimeSelectionPage extends StatefulWidget {
  final int service;
  final int subCategory;
  final Area area;
  final String address;
  final String problem;

  const TimeSelectionPage(
      {Key key,
      this.area,
      this.address,
      this.problem,
      this.service,
      this.subCategory})
      : super(key: key);

  @override
  _TimeSelectionPageState createState() => _TimeSelectionPageState();
}

class _TimeSelectionPageState extends State<TimeSelectionPage> {
  DateSelector _selector;
  DateTime _time;
  String startDate;
  String endDate;

  @override
  void initState() {
    super.initState();
    _selector = DateSelector.TODAY;
    _time = DateTime.now();
    startDate = DateTime.now().toString();
    endDate = DateTime.now().toString();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
        customTitle: Column(
          children: <Widget>[
            Text(AppTranslations.of(context).text(StringResources.completed_70),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                )),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: LinearProgressIndicator(
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation<Color>(
                    ColorResources.proggressBarColor),
                value: 0.7,
              ),
            ),
          ],
        ),
        hasBack: true,
        trailing: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppTranslations.of(context).text(StringResources.choose_preffered_time),
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Divider(),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    _generateListTile(AppTranslations.of(context).text(StringResources.today), false, DateSelector.TODAY,
                        onPressed: () {
                      setState(() {
                        _selector = DateSelector.TODAY;
                        startDate = DateTime.now().toString();
                        endDate = DateTime.now().toString();
                      });
                    }),
                    _generateListTile(AppTranslations.of(context).text(StringResources.tomorrow), false, DateSelector.TOMORROW,
                        onPressed: () {
                      setState(() {
                        _selector = DateSelector.TOMORROW;
                        startDate = DateTime.now().add(Duration(days: 1)).toString();
                        endDate = DateTime.now().add(Duration(days: 1)).toString();
                      });
                    }),
                    _generateListTile(AppTranslations.of(context).text(StringResources.calendar), true, DateSelector.CALENDER,
                        onPressed: () async {
//                      DateTime today = DateTime.now();
//                      DateTime end = DateTime.now().add(Duration(days: 7));
//                      print(today);
//                      print(end);
                      setState(() {
                        _selector = DateSelector.CALENDER;
                      });
//                      final List<DateTime> picked = await DateRagePicker.showDatePicker(
//                          context: context,
//                          initialFirstDate: today,
//                          initialLastDate: end,
//                          firstDate: new DateTime(2015),
//                          lastDate: new DateTime(2020)
//                      );
//                      if (picked != null && picked.length == 2) {
//                        print(picked);
//                      }
//                      DatePicker.showDatePicker(context,
//                          showTitleActions: true,
//                          minTime: DateTime(2018, 3, 5),
//                          maxTime: DateTime(2019, 6, 7), onChanged: (date) {
//                        setState(() {
//                          _time = date;
//                        });
//                      }, onConfirm: (date) {
//                        setState(() {
//                          _time = date;
//                          selectedDate = _time.toString();
//                        });
//                      }, currentTime: DateTime.now());
                    }),
                    Visibility(
                      visible: _selector == DateSelector.CALENDER,
                      child: Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children:[
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex:1,
                              child: RaisedButton(
                                child:Text(AppTranslations.of(context).text(StringResources.from),style: StyleResources.primaryButton(),),
                                color: ColorResources.primaryColor,
                                onPressed: (){
                                  DatePicker.showDateTimePicker(context,
                                      showTitleActions: true,
                                      minTime:  DateTime.now(),
                                      maxTime: DateTime.now().add(Duration(days: 60),
                                      ), onChanged: (date) {
                                        setState(() {
                                          _time = date;
                                        });
                                      }, onConfirm: (date) {
                                        setState(() {
                                          _time = date;
                                          startDate = _time.toString();
                                        });
                                      }, currentTime: DateTime.now());
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex:1,
                              child: RaisedButton(
                                child:Text(AppTranslations.of(context).text(StringResources.to),style: StyleResources.primaryButton()),
                                color: ColorResources.primaryColor,
                                onPressed: (){
                                  DatePicker.showDateTimePicker(context,
                                      showTitleActions: true,
                                      minTime: DateTime.now(),
                                      maxTime: DateTime.now().add(Duration(days: 60)), onChanged: (date) {
                                        setState(() {
                                          _time = date;
                                        });
                                      }, onConfirm: (date) {
                                        setState(() {
                                          _time = date;
                                          endDate = _time.toString();
                                        });
                                      }, currentTime: DateTime.now());
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ]
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _selector == DateSelector.CALENDER,
                      child: Container(
                        width: MediaQuery.of(context).size.width-100,
                        child: Center(
                          child: Text(
                            AppTranslations.of(context).text(StringResources.selected_on) +  " \n${startDate.toString()} \n${endDate.toString()}",
                            maxLines: 3,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width - 75,
                    height: MediaQuery.of(context).size.width / 8,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ImagePage(
                                  service: widget.service,
                                  subCategory: widget.subCategory,
                                  area: widget.area,
                                  address: widget.address,
                                  problem: widget.problem,
                                  time: startDate,
                                  time1:endDate,)),
                        );
                      },
                      color: ColorResources.primaryColor,
                      child: Text(
                        AppTranslations.of(context).text(StringResources.next) ,
                        style: StyleResources.primaryButton(),
                      ),
                    )),
              ),
              SizedBox(
                height: 25,
              )
            ],
          ),
        ));
  }

  _generateListTile(String place, bool isSelected, DateSelector dateSelector,
      {VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: <Widget>[
          ListTile(
            selected: _selector == dateSelector,
            title: Text(place),
            trailing: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey,
                    )),
                child: _selector == dateSelector
                    ? Icon(Icons.check)
                    : Container(
                        width: 0,
                        height: 0,
                      )),
          ),
          Divider(
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}

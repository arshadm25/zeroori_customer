import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:zeroori_customer/models/area.dart';
import 'package:zeroori_customer/pages/BasePage.dart';
import 'package:zeroori_customer/pages/image_page.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/resources/style_resources.dart';

enum DateSelector{
  TODAY,
  TOMORROW,
  CALENDER
}
class TimeSelectionPage extends StatefulWidget {
  final int service;
  final int subCategory;
  final Area area;
  final String address;
  final String problem;

  const TimeSelectionPage({Key key, this.area, this.address, this.problem, this.service, this.subCategory}) : super(key: key);

  @override
  _TimeSelectionPageState createState() => _TimeSelectionPageState();
}

class _TimeSelectionPageState extends State<TimeSelectionPage> {
  DateSelector _selector;
  DateTime _time;
  String selectedDate;

  @override
  void initState() {
    super.initState();
    _selector = DateSelector.TODAY;
    _time = DateTime.now();
    selectedDate = DateTime.now().toString();
  }
  @override
  Widget build(BuildContext context) {
    return BasePage(
      customTitle:Column(
        children: <Widget>[
          Text("Completed 70%",style:TextStyle(
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
              value: 0.7,
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
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Choose the preferred time of execuition",style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),),
            ),
            Divider(),
            Expanded(
              child: ListView(
                children: <Widget>[
                  _generateListTile("Today", false,DateSelector.TODAY,onPressed: (){
                    setState(() {
                      _selector = DateSelector.TODAY;
                      selectedDate = DateTime.now().toString();
                    });
                  }),
                  _generateListTile("Tomorrow", false,DateSelector.TOMORROW,onPressed: (){
                    setState(() {
                      _selector = DateSelector.TOMORROW;
                      selectedDate = DateTime.now().add(Duration(days: 1)).toString();
                    });
                  }),
                  _generateListTile("Calender", true,DateSelector.CALENDER,onPressed:() async {
                    setState(() {
                      _selector = DateSelector.CALENDER;
                    });
                     DatePicker.showDateTimePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(2018, 3, 5),
                        maxTime: DateTime(2019, 6, 7), onChanged: (date) {
                          setState(() {
                            _time  = date;
                          });
                        }, onConfirm: (date) {
                           setState(() {
                             _time  = date;
                             selectedDate = _time.toString();
                           });
                        }, currentTime: DateTime.now());
                  }),
                  Visibility(
                    visible: _selector == DateSelector.CALENDER,
                    child: Container(
                      child: Center(
                          child: Text("Selected On ${_time.toString()}",style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width-75,
                  height: MediaQuery.of(context).size.width/8,
                  child:RaisedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>ImagePage(
                          service:widget.service,
                          subCategory:widget.subCategory,
                          area: widget.area,
                          address: widget.address,
                          problem: widget.problem,
                          time:selectedDate
                        )
                      ),);
                    },
                    color: ColorResources.primaryColor,
                    child: Text("Next",style: StyleResources.primaryButton(),),
                  )
              ),
            ),
            SizedBox(
              height: 25,
            )
          ],
        ),
      )
    );
  }

  _generateListTile(String place,bool isSelected,DateSelector dateSelector,{VoidCallback onPressed}){
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
                )
              ),
              child: _selector==dateSelector?Icon(Icons.check):Container(width: 0,height: 0,)
            ),
          ),
          Divider(
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}

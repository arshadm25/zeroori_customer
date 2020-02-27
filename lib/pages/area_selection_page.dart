import 'package:flutter/material.dart';
import 'package:zeroori_customer/pages/BasePage.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/resources/style_resources.dart';

class AreaSelectionPage extends StatefulWidget {

  @override
  _AreaSelectionPageState createState() => _AreaSelectionPageState();
}

class _AreaSelectionPageState extends State<AreaSelectionPage> {
  bool dohaSelected;
  bool alWakrahSelected;
  bool alKhorSelected;
  bool alRayyanSelected;
  bool alGowriyaSelected;
  bool alJamilyaSelected;

  @override
  void initState() {
    super.initState();
    dohaSelected = false;
    alWakrahSelected = false;
    alKhorSelected = false;
    alRayyanSelected = false;
    alGowriyaSelected = false;
    alJamilyaSelected = false;

  }
  @override
  Widget build(BuildContext context) {
    return BasePage(
      customTitle:Column(
        children: <Widget>[
          Text("Completed 20%",style:TextStyle(
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
              value: 0.2,
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
              child: Text("Select Area",style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),),
            ),
            Divider(),
            Expanded(
              child: ListView(
                children: <Widget>[
                  _generateListTile("Doha", dohaSelected,onSelected: (){
                    initializeSelected();
                    setState(() {
                      dohaSelected = true;
                    });
                  }),
                  _generateListTile("Al Wakrah", alWakrahSelected,onSelected: (){
                    initializeSelected();
                    setState(() {
                      alWakrahSelected = true;
                    });
                  }),
                  _generateListTile("Al Khor", alKhorSelected,onSelected: (){
                    initializeSelected();
                    setState(() {
                      alKhorSelected = true;
                    });
                  }),
                  _generateListTile("Al Rayyan", alRayyanSelected,onSelected: (){
                    initializeSelected();
                    setState(() {
                      alRayyanSelected = true;
                    });
                  }),
                  _generateListTile("Al Gowarriya", alGowriyaSelected,onSelected: (){
                    initializeSelected();
                    setState(() {
                      alGowriyaSelected = true;
                    });
                  }),
                  _generateListTile("Aljamilya", alJamilyaSelected,onSelected: (){
                    initializeSelected();
                    setState(() {
                      alJamilyaSelected = true;
                    });
                  }),

                ],
              ),
            ),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width-75,
                height: 60,
                child: RaisedButton(
                  color: ColorResources.primaryColor,
                  child: Text("Next",style: StyleResources.primaryButton(),),
                  onPressed: (){
                    Navigator.pushNamed(context, 'select_map');
                  },

                ),
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

  _generateListTile(String place,bool isSelected,{VoidCallback onSelected}){
    return Column(
      children: <Widget>[
        ListTile(
          selected: isSelected,
          onTap: onSelected,
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
            child: isSelected?Icon(Icons.check):Container(width: 0,height: 0,)
          ),
        ),
        Divider(
          color: Colors.grey,
        )
      ],
    );
  }

  initializeSelected(){
    setState(() {
      dohaSelected = false;
      alWakrahSelected = false;
      alKhorSelected = false;
      alRayyanSelected = false;
      alGowriyaSelected = false;
      alJamilyaSelected = false;
    });
  }
}

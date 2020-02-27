import 'package:flutter/material.dart';
import 'package:zeroori_customer/pages/BasePage.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/resources/style_resources.dart';

class MapSelectionPage extends StatefulWidget {

  @override
  _MapSelectionPageState createState() => _MapSelectionPageState();
}

class _MapSelectionPageState extends State<MapSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      customTitle:Column(
        children: <Widget>[
          Text("Completed 40%",style:TextStyle(
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
              value: 0.4
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
//        color: Colors.white,
        child: Stack(
          children: [
            InkWell(
              onTap: (){
                showModal();
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.grey,
                child:Image.asset("assets/map.png",width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,fit: BoxFit.cover,)
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                color: Colors.white,
                child: TextFormField(

                  decoration: InputDecoration(
                    labelText: "Search",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorResources.primaryColor),
                        borderRadius: BorderRadius.circular(5),
                    ),
                    hasFloatingPlaceholder: true,
                    suffixIcon: Icon(Icons.search,color: ColorResources.primaryColor,),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorResources.primaryColor),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
          ]
        ),
      ),
//      bottomSheet: BottomSheet(
//        elevation: 4.0,
//        onClosing: (){
//        },
//        shape: RoundedRectangleBorder(
//            borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
//        ),
//        builder: (context)=>Container(
////          decoration: BoxDecoration(
////              borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
////          ),
//          width: MediaQuery.of(context).size.width,
//          height: MediaQuery.of(context).size.height/3,
//          child: Padding(
//            padding: const EdgeInsets.all(8.0),
//            child: Stack(
//                children: [
//              Positioned(
//                right: 0,
//                top: 0,
//                child: Container(
//                  width: 30,
//                  height: 30,
//                  decoration: BoxDecoration(
//                    shape: BoxShape.circle,
//                    color: Colors.grey.withOpacity(0.4),
//                  ),
//                  child: Icon(Icons.close),
//                ),
//              ),
//                  Container(
//                    decoration:BoxDecoration(
//                        borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
//                    ),
//                    child: Column(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                      children: <Widget>[
//                        Padding(
//                          padding: const EdgeInsets.all(36.0),
//                          child: Column(
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            crossAxisAlignment: CrossAxisAlignment.center,
//                            children: <Widget>[
//                              Text("Current Location",style: TextStyle(
//                                color: Colors.black87,
//                                fontWeight: FontWeight.bold,
//                                fontSize: 25,
//                              ),),
//                              Text("Government Office in C-Ring Road Qatar",maxLines: 2,style: TextStyle(
//                                fontSize: 18,
//                                color: Colors.grey
//                              ),),
//
//
//                            ],
//                          ),
//                        ),
//                        Column(
//                          crossAxisAlignment: CrossAxisAlignment.center,
//                          children: <Widget>[
//                            Row(
//                            mainAxisAlignment:MainAxisAlignment.center,
//                          children: [
//                              Icon(Icons.refresh,color: ColorResources.primaryColor,),
//                              SizedBox(width:10),
//                              Text("Recent Locations",style:TextStyle(
//                                color: ColorResources.primaryColor,
//                                fontSize: 15
//                              ))
//                            ]),
//                            SizedBox(
//                              height: 10,
//                            ),
//                            SizedBox(
//                              width: MediaQuery.of(context).size.width-75,
//                              height: 60,
//                              child: RaisedButton(
//                                onPressed: (){
//                                  Navigator.pushNamed(context, 'describe_problem');
//                                },
//                                color: ColorResources.primaryColor,
//                                child: Text("Select The Location",style: StyleResources.primaryButton(),),
//                              ),
//                            )
//                          ],
//                        ),
//                      ],
//                    ),
//                  )
//            ],),
//          ),
//        ),
//      ),
    );
  }

  showModal(){
    showModalBottomSheet(context: context, builder: (context){
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height/2.5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Positioned(
                right: 0,
                top: 0,
                child: InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.withOpacity(0.4),
                    ),
                    child: Icon(Icons.close),
                  ),
                ),
              ),
              Container(
                decoration:BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(36.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Current Location",style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),),
                          SizedBox(height: 25,),
                          Text("Government Office in C-Ring Road Qatar",maxLines: 2,style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey
                          ),),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Row(
                              mainAxisAlignment:MainAxisAlignment.center,
                              children: [
                                Icon(Icons.refresh,color: ColorResources.primaryColor,),
                                SizedBox(width:10),
                                Text("Recent Locations",style:TextStyle(
                                    color: ColorResources.primaryColor,
                                    fontSize: 15
                                ))
                              ]),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width-75,
                          height: 60,
                          child: RaisedButton(
                            onPressed: (){
                              Navigator.pushNamed(context, 'describe_problem');
                            },
                            color: ColorResources.primaryColor,
                            child: Text("Select The Location",style: StyleResources.primaryButton(),),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],),
        ),
      );
    });
  }
}

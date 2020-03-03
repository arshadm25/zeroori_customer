import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zeroori_customer/models/area.dart';
import 'package:zeroori_customer/pages/BasePage.dart';
import 'package:zeroori_customer/pages/confirm_page.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/resources/style_resources.dart';
import 'package:zeroori_customer/utils/dialogs.dart';

class ImagePage extends StatefulWidget {
  final int service;
  final int subCategory;
  final Area area;
  final String address;
  final String problem;
  final String time;

  const ImagePage({Key key, this.area, this.address, this.problem, this.time, this.service, this.subCategory,}) : super(key: key);

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  List<File> images;
  File file1;
  File file2;
  File file3;
  File file4;
  File file5;
  File file6;

  @override
  void initState() {
    super.initState();
    images = [
      file1,
      file2,
      file3,
      file4,
      file5,
      file6
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      customTitle:Column(
        children: <Widget>[
          Text("Completed 80%",style:TextStyle(
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
              value: 0.8,
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
      child: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex:1,
                  child: Container(
                    color: ColorResources.primaryColor,
                    height: MediaQuery.of(context).size.height/4-40,
                  ),
                ),
                Expanded(
                  flex:2,
                  child: Container(
                    color: Colors.transparent,
                    height: MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height/4-40),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: ColorResources.primaryColor,
                    height: (MediaQuery.of(context).size.height/4)-40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 15,
                        ),
                        Text("Add Photo",style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Adding more images to your folder will help in understand the problem",maxLines: 2,style: TextStyle(
                          color: Colors.white,
                          fontSize: 15
                        ),)
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    height: MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height/4)-40,
                    child: GridView.builder(
                      itemCount: images.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.2,
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 30
                      ),
                      itemBuilder: (context,index)=>_generateGridItem(index),
                    ),
                  ),
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width-75,
                    height: 60,
                    child:RaisedButton(
                      onPressed: (){
                        Dialogs.showLoader(context);
                        List<File> ims = [];
                        images.forEach((i){
                          if(i!=null){
                            ims.add(i);
                          }
                        });

                        if(ims.length>0){
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context)=>ConfirmPage(
                                service:widget.service,
                                subCategory:widget.subCategory,
                                area: widget.area,
                                address: widget.address,
                                problem: widget.problem,
                                images: ims,
                                time: widget.time,
                              )
                          ));
                        }else{
                          Navigator.pop(context);
                          Dialogs.showMessage(context,title: "Oops!",message: "Please choose a valid image");
                        }

                      },
                      color: ColorResources.primaryColor,
                      child: Text("NEXT",style: StyleResources.primaryButton(),),
                    )
                ),
                SizedBox(height: 25,),
              ],

            ),
          )

        ],
      ),
    );
  }

  _generateGridItem(int index){
    return InkWell(
      onTap: () async {
        File file = await ImagePicker.pickImage(source: ImageSource.camera);
        setState(() {
          images[index] = file;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: Colors.white,shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      offset: Offset(5,2),
                      blurRadius: 5.0
                  )
                ]
            ),
            child: images[index]!=null?Image.file(
              images[index],
              fit: BoxFit.contain,
            ):Icon(Icons.image,color: ColorResources.primaryColor,),
          ),
          SizedBox(height: 10,),
          Text(
            "Image",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13
            ),
          )
        ]
      ),
    );
  }
}

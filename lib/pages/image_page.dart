import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zeroori_customer/pages/BasePage.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/resources/style_resources.dart';

class ImagePage extends StatelessWidget {
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
                      itemCount: 6,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.2,
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 30
                      ),
                      itemBuilder: (context,index)=>_generateGridItem(),
                    ),
                  ),
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width-75,
                    height: 60,
                    child:RaisedButton(
                      onPressed: (){
                        Navigator.pushNamed(context, 'confirm');
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

  _generateGridItem(){
    return InkWell(
      onTap: () async {
        await ImagePicker.pickImage(source: ImageSource.camera);
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
            child: Icon(Icons.image,color: ColorResources.primaryColor,),
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

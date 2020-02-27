import 'package:flutter/material.dart';
import 'package:zeroori_customer/pages/BasePage.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/resources/style_resources.dart';
import 'package:zeroori_customer/widgets/dialogs/message_dialog.dart';

class ConfirmPage extends StatelessWidget {

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
                  ),
                  TextFormField(
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: "Location",
                      hasFloatingPlaceholder: true,
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Request Description",
                        hasFloatingPlaceholder: true
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Preffered Time",
                        hasFloatingPlaceholder: true
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width-75,
                height: 60,
                child:RaisedButton(
                  onPressed: (){
                    showDialog(context: context,builder: (context)=>MessageDialog(
                      title: "Success",
                      message: "Our Representative will contact you soon",
                      onClose: (){
                        Navigator.pushNamed(context, 'my_orders');
                      },
                    ));
                  },
                  color: ColorResources.primaryColor,
                  child: Text("Confirm and Send",style: StyleResources.primaryButton(),),
                )
            ),
            SizedBox(height: 15,)
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:zeroori_customer/resources/color_resources.dart';

class OrderDetailImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.width/5)+20,
      child: Stack(
        children:[
          Container(
            width: MediaQuery.of(context).size.width/5,
            height: MediaQuery.of(context).size.width/5,
            decoration: BoxDecoration(
              color: Colors.white,
              border:Border.all(color:ColorResources.primaryColor,width:2,),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Image.asset("assets/ac.jpg",fit: BoxFit.cover,),
          ),
          Positioned(
            bottom: 0,
            left: (MediaQuery.of(context).size.width/5)/4,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorResources.primaryColor,
                ),
                width: 50,height: 50,
                child: Icon(Icons.call,color: Colors.white,),
              ),
            ),
          )
        ],
      ),
    );
  }
}

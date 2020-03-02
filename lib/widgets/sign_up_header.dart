
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/widgets/profile_image_add_widget.dart';
import 'package:zeroori_customer/widgets/utils/custom_rect.dart';

class SignUpHeader extends StatelessWidget {
  final String title;
  final String image;
  final String isNetwork;
  final File file;
  final VoidCallback onImageSelected;

  const SignUpHeader({Key key, this.title:"Sign Up",this.onImageSelected, this.image, this.isNetwork, this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onImageSelected??(){},
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.width / 2.2,
          ),
          Container(
            child: Stack(
              children: [
                Transform.rotate(
                  angle: 3.14,
                  child: ClipOval(
                    clipBehavior: Clip.antiAlias,
                    clipper: CustomRect(),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 6,
                      decoration:
                          BoxDecoration(color: ColorResources.primaryColor),

                    ),
                  ),
                ),
                SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 25,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3.5,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          this.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            right: (MediaQuery.of(context).size.width / 2) -
                ((MediaQuery.of(context).size.width / 5) / 2),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ProfileImageAddWidget(
                file: file,
                isNetwork: this.isNetwork!=null,
                image: this.isNetwork,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

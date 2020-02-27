import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zeroori_customer/resources/image_resources.dart';

class ProfileImageAddWidget extends StatelessWidget {
  final String image;
  final File file;
  final bool isNetwork;

  const ProfileImageAddWidget(
      {Key key, this.image, this.isNetwork: false, this.file})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 5,
          height: MediaQuery.of(context).size.width / 5,
          decoration: BoxDecoration(
              color: Color(0x162344).withOpacity(1),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 3,
              ),
          ),
          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(MediaQuery.of(context).size.width / 10),
            child: this.isNetwork
                ? FadeInImage.assetNetwork(
                    placeholder: ImageResources.userDummy,
                    image: this.image,
                  )
                : (this.file != null
                    ? Image.file(
                        this.file,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        ImageResources.userDummy,

                      )),
          ),
        ),
        Positioned(
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0x25DB5B).withOpacity(1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

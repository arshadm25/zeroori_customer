import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/resources/string_resources.dart';
import 'package:zeroori_customer/resources/style_resources.dart';

class RatingDialog extends StatefulWidget {
  final Function(double,String) onRatingCompleted;

  const RatingDialog({Key key, this.onRatingCompleted})
      : super(key: key);

  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  double rating;
  TextEditingController descriptionController;

  @override
  void initState() {
    rating = 0;
    descriptionController = TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          width: 300,
          height: MediaQuery.of(context).size.height/3.2,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                  right: 5,
                  top: 5,
                  child: InkWell(
                    onTap:
                        () {
                          Navigator.pop(context);
                        },
                    child: Container(
                      padding: EdgeInsets.all(1.0),
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      child: Icon(Icons.close),
                    ),
                  )),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Rate Now",
                      style: StyleResources.dialogHeader(context),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Please Rate our service",
                      textAlign: TextAlign.center,
                      style: StyleResources.dialogContent(context),
                    ),
                    SmoothStarRating(
                        allowHalfRating: false,
                        onRatingChanged: (v) {
                          setState(() {
                            rating = v;
                          });
                        },
                        starCount: 5,
                        rating: rating,
                        size: 40.0,
                        filledIconData: Icons.star,
                        halfFilledIconData: Icons.star_half,
                        color: Colors.yellow,
                        borderColor: Colors.yellow,
                        spacing:0.0
                    ),
                    TextFormField(
                      maxLines: 3,
                      controller: descriptionController,
                      decoration: InputDecoration(
                        labelText: "Description",
                        hasFloatingPlaceholder: true,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        color: ColorResources.primaryColor,
                        child: Text(
                          StringResources.ok,
                          style: StyleResources.primaryButton(),
                        ),
                        onPressed: (){
                          widget.onRatingCompleted(rating,descriptionController.text);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

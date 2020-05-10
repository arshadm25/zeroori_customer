import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zeroori_customer/models/area.dart';
import 'package:zeroori_customer/pages/BasePage.dart';
import 'package:zeroori_customer/pages/time_selection_page.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/resources/string_resources.dart';
import 'package:zeroori_customer/resources/style_resources.dart';
import 'package:zeroori_customer/utils/app_translations.dart';
import 'package:zeroori_customer/utils/dialogs.dart';

class DescribeProblemPage extends StatefulWidget {
  final int service;
  final int subCategory;
  final Area area;
  final String address;

  const DescribeProblemPage(
      {Key key, this.area, this.address, this.service, this.subCategory})
      : super(key: key);

  @override
  _DescribeProblemPageState createState() => _DescribeProblemPageState();
}

class _DescribeProblemPageState extends State<DescribeProblemPage> {
  TextEditingController problemController;

  @override
  void initState() {
    super.initState();
    problemController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      customTitle: Column(
        children: <Widget>[
          Text(AppTranslations.of(context).text(StringResources.completed_60),
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              )),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: LinearProgressIndicator(
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(
                  ColorResources.proggressBarColor),
              value: 0.6,
            ),
          ),
        ],
      ),
      hasBack: true,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      offset: Offset(3, 3), color: Colors.grey.withOpacity(0.5))
                ]),
                height: (MediaQuery.of(context).size.height / 2.5),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppTranslations.of(context).text(StringResources.describe_your_problem),
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          AppTranslations.of(context).text(StringResources.describe_your_problem_very_clearly),
                          maxLines: 3,
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(fontSize: 15),
                        ),
                        TextField(
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: AppTranslations.of(context).text(StringResources.type_here),
                          ),
                          controller: problemController,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  color: ColorResources.primaryColor,
                  onPressed: () {
                    Dialogs.showLoader(context);
                    if (problemController.text.isEmpty) {
                      Navigator.pop(context);
                      Dialogs.showMessage(context,
                          title:  AppTranslations.of(context).text(StringResources.oops),
                          message: AppTranslations.of(context).text(StringResources.please_enter_valid_problem));
                    } else {
                      Navigator.pop(context);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TimeSelectionPage(
                                    area: widget.area,
                                    service: widget.service,
                                    subCategory: widget.subCategory,
                                    address: widget.address,
                                    problem: problemController.text,
                                  )));
                    }
                  },
                  child: Text(
                    AppTranslations.of(context).text(StringResources.next),
                    style: StyleResources.primaryButton(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

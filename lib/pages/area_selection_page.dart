import 'package:flutter/material.dart';
import 'package:zeroori_customer/models/area.dart';
import 'package:zeroori_customer/pages/BasePage.dart';
import 'package:zeroori_customer/pages/map_selection_page.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/resources/string_resources.dart';
import 'package:zeroori_customer/resources/style_resources.dart';
import 'package:zeroori_customer/services/area_services.dart';
import 'package:zeroori_customer/utils/app_translations.dart';
import 'package:zeroori_customer/utils/dialogs.dart';

class AreaSelectionPage extends StatefulWidget {
  final int service;
  final int subCategory;

  const AreaSelectionPage({Key key, this.service, this.subCategory})
      : super(key: key);

  @override
  _AreaSelectionPageState createState() => _AreaSelectionPageState();
}

class _AreaSelectionPageState extends State<AreaSelectionPage> {
  List<Area> areas;
  Area selectedArea;

  @override
  void initState() {
    super.initState();
    areas = AreaServices.getAreas();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
        customTitle: Column(
          children: <Widget>[
            Text(AppTranslations.of(context).text(StringResources.completed_20),
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
                value: 0.2,
              ),
            ),
          ],
        ),
        hasBack: true,
        trailing: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () {
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
                child: Text(
                  AppTranslations.of(context).text(StringResources.select_area),
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: areas.length,
                  itemBuilder: (context, index) {
                    return _generateListTile(
                        areas[index].name, selectedArea == areas[index],
                        onSelected: () {
                      initializeSelected();
                      setState(() {
                        selectedArea = areas[index];
                      });
                    });
                  },
                ),
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 75,
                  height: 50,
                  child: RaisedButton(
                    color: ColorResources.primaryColor,
                    child: Text(
                      AppTranslations.of(context).text(StringResources.next),
                      style: StyleResources.primaryButton(),
                    ),
                    onPressed: () {
                      Dialogs.showLoader(context);
                      if (selectedArea == null) {
                        Navigator.pop(context);
                        Dialogs.showMessage(context,
                            title: AppTranslations.of(context).text(StringResources.oops), message: AppTranslations.of(context).text(StringResources.please_choose_an_area));
                      } else {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapSelectionPage(
                              service: widget.service,
                              subCategory: widget.subCategory,
                              area: selectedArea,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              )
            ],
          ),
        ));
  }

  _generateListTile(String place, bool isSelected, {VoidCallback onSelected}) {
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
                  )),
              child: isSelected
                  ? Icon(Icons.check)
                  : Container(
                      width: 0,
                      height: 0,
                    )),
        ),
        Divider(
          color: Colors.grey,
        )
      ],
    );
  }

  initializeSelected() {
    setState(() {
      areas = AreaServices.getAreas();
    });
  }
}

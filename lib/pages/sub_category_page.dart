import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeroori_customer/bloc/sub_service_bloc/bloc.dart';
import 'package:zeroori_customer/models/sub_service.dart';
import 'package:zeroori_customer/pages/BasePage.dart';
import 'package:zeroori_customer/pages/fill_order_page.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/resources/image_resources.dart';
import 'package:zeroori_customer/resources/string_resources.dart';
import 'package:zeroori_customer/utils/app_translations.dart';

class SubCategoryPage extends StatefulWidget {
  final int id;

  const SubCategoryPage({Key key, this.id}) : super(key: key);

  @override
  _SubCategoryPageState createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {
  SubServiceListBloc subServiceListBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    subServiceListBloc = BlocProvider.of<SubServiceListBloc>(context);
    subServiceListBloc.add(GetServices(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
        title: AppTranslations.of(context).text(StringResources.subCategory),
        hasBack: false,
        trailing: IconButton(
          icon: Icon(
            Icons.notifications,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamed(context, RouteNames.notificationPage);
          },
        ),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: BlocBuilder<SubServiceListBloc, SubServiceListState>(
              builder: (context, state) {
                if (state is Loading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is Loaded) {
                  return Container(
                    padding: EdgeInsets.all(8.0),
                    height: MediaQuery.of(context).size.height -
                        (MediaQuery.of(context).size.height / 4) -
                        40,
                    child: GridView.builder(
                      itemCount: state.services.length,
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10),
                      itemBuilder: (context, index) =>
                          _generateGridItem(state.services[index]),
                    ),
                  );
                }
                return Center(
                    child: Text(AppTranslations.of(context).text(StringResources.noSubCategoryFound),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ));
              },
            ),
          ),
        ),
        bottomNavigationBar: _generateBottomNavigationBar());
  }

  _generateBottomNavigationBar() {
    return BottomNavigationBar(
      elevation: 8.0,
      backgroundColor: Colors.white,
      selectedIconTheme: IconThemeData(
        color: ColorResources.primaryColor,
      ),
      selectedItemColor: ColorResources.primaryColor,
      unselectedIconTheme: IconThemeData(color: Colors.grey),
      currentIndex: 0,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, RouteNames.servicePage);
            break;
          case 1:
            Navigator.pushNamed(context, RouteNames.myOrdersPage);
            break;
          case 2:
            Navigator.pushNamed(context, RouteNames.myProfilePage);
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.layers),
          title: Text(AppTranslations.of(context).text(StringResources.services)),
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text(AppTranslations.of(context).text(StringResources.myOrders))),
        BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz), title: Text(AppTranslations.of(context).text(StringResources.more)))
      ],
    );
  }

  _generateGridItem(SubService service) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FillOrderPage(
                    service: widget.id, subCategory: service.id)));
      },
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  offset: Offset(5, 2),
                  blurRadius: 5.0)
            ]),
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 8,
                child: FadeInImage.assetNetwork(
                  placeholder: ImageResources.dummyService,
                  image: service.image,
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  service.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
                ),
              )
            ]),
      ),
    );
  }
}

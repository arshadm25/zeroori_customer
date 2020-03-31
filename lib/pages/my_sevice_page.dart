import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeroori_customer/bloc/service_bloc/bloc.dart' as serviceBloc;
import 'package:zeroori_customer/bloc/slider_bloc/bloc.dart';
import 'package:zeroori_customer/bloc/sub_service_bloc/bloc.dart' as subServiceBloc;
import 'package:zeroori_customer/models/Service.dart';
import 'package:zeroori_customer/pages/BasePage.dart';
import 'package:zeroori_customer/pages/sub_category_page.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/resources/string_resources.dart';
import 'package:zeroori_customer/utils/app_translations.dart';
import 'package:zeroori_customer/widgets/slider_widget.dart';

class MyServicePage extends StatefulWidget {
  @override
  _MyServicePageState createState() => _MyServicePageState();
}

class _MyServicePageState extends State<MyServicePage> {
  SliderListBloc bloc;
  serviceBloc.ServiceListBloc serviceListBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = BlocProvider.of<SliderListBloc>(context);
    serviceListBloc = BlocProvider.of<serviceBloc.ServiceListBloc>(context);
    bloc.add(GetSliders());
    serviceListBloc.add(serviceBloc.GetServices());
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
        title:AppTranslations.of(context).text(StringResources.myServices),
        hasBack: false,
        trailing: IconButton(
          icon: Icon(
            Icons.notifications,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamed(context, 'notification');
          },
        ),
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  BlocBuilder<SliderListBloc, SliderListState>(
                    builder: (context, state) {
                      if (state is Loading) {
                        return Text(AppTranslations.of(context).text(StringResources.loading));
                      }
                      if (state is Loaded) {
                        return SliderWidget(
                          sliders: state.sliders,
                        );
                      }
                      if (state is Error) {
                        return Text(state.message);
                      }
                      return Text(AppTranslations.of(context).text(StringResources.no_items_found));
                    },
                  ),
                  Expanded(
                    child: Container(),
                  )
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.transparent,
                      height: (MediaQuery.of(context).size.height / 4) - 40,
                    ),
                    BlocBuilder<serviceBloc.ServiceListBloc,
                        serviceBloc.ServiceListState>(
                      builder: (context, state) {
                        if (state is serviceBloc.Loading) {
                          return Center(
                            child: Text(AppTranslations.of(context).text(StringResources.loading)),
                          );
                        }
                        if (state is serviceBloc.Loaded) {
                          return Container(
                            padding: EdgeInsets.all(8.0),
                            height: MediaQuery.of(context).size.height -
                                (MediaQuery.of(context).size.height / 4) -
                                80,
                            child: GridView.builder(
                              itemCount: state.services.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: 1,
                                      mainAxisSpacing: 0,
                                      crossAxisSpacing: 30),
                              itemBuilder: (context, index) =>
                                  _generateGridItem(state.services[index]),
                            ),
                          );
                        }
                        if (state is serviceBloc.Error) {
                          return Text(state.message);
                        }
                        return Center(
                          child: Text(AppTranslations.of(context).text(StringResources.no_services)),
                        );
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: (){
//
//        },
//        backgroundColor: ColorResources.floatingActionButtonColor,
//        child: Icon(Icons.chat),
//      ),
        bottomNavigationBar: _generateBottomNavigationBar());
  }

  _generateBottomNavigationBar() {
    return BottomNavigationBar(
      elevation: 8.0,
      currentIndex: 0,
      backgroundColor: Colors.white,
      selectedIconTheme: IconThemeData(
        color: ColorResources.primaryColor,
      ),
      selectedItemColor: ColorResources.primaryColor,
      unselectedIconTheme: IconThemeData(color: Colors.grey),
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, 'services');
            break;
          case 1:
            Navigator.pushNamed(context, 'my_orders');
            break;
          case 2:
            Navigator.pushNamed(context, 'my_orders');
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
          title: Text(AppTranslations.of(context).text(StringResources.myOrders)),
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz), title: Text(AppTranslations.of(context).text(StringResources.more)))
      ],
    );
  }

  _generateGridItem(Service service) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    BlocProvider<subServiceBloc.SubServiceListBloc>(
                      create: (context) => subServiceBloc.SubServiceListBloc(),
                      child: SubCategoryPage(id: service.id),
                    )));
      },
      child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: 50,
                height: 50,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(5, 2),
                          blurRadius: 5.0)
                    ]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: FadeInImage.assetNetwork(
                    placeholder: "assets/ac.jpg",
                    image: service.image,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                )),
            SizedBox(
              height: 10,
            ),
            Text(
              service.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13),
            )
          ]),
    );
  }
}

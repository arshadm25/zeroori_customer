import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeroori_customer/bloc/order_list_bloc/bloc.dart';
import 'package:zeroori_customer/pages/BasePage.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/resources/string_resources.dart';
import 'package:zeroori_customer/services/order_services.dart';
import 'package:zeroori_customer/utils/app_translations.dart';
import 'package:zeroori_customer/widgets/order_item.dart';

class MyOrdersPage extends StatefulWidget {
  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage>
    with SingleTickerProviderStateMixin {
  OrderListBloc orderListBloc;
  int currentIndex = 0;
  TabController _tabController;

  @override
  initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
    _tabController.addListener(_onTabChanged);
  }

  _onTabChanged() {
    switch (_tabController.index) {
      case 0:
        orderListBloc.add(GetOrders(OrderStatus.NEW));
        setState(() {
          currentIndex = 1;
        });
        break;
      case 1:
        orderListBloc.add(GetOrders(OrderStatus.IN_PROGRESS));
        setState(() {
          currentIndex = 2;
        });
        break;
      case 2:
        orderListBloc.add(GetOrders(OrderStatus.COMPLETED));
        setState(() {
          currentIndex = 3;
        });
        break;
      case 3:
        orderListBloc.add(GetOrders(OrderStatus.CANCELLED));
        setState(() {
          currentIndex = 0;
        });
        break;
      default:
        orderListBloc.add(GetOrders(OrderStatus.ALL));
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    orderListBloc = BlocProvider.of<OrderListBloc>(context);
    orderListBloc.add(GetOrders(OrderStatus.NEW));

    currentIndex = 0;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      hasBack: false,
      title: AppTranslations.of(context).text(StringResources.myOrders),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              color: ColorResources.primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TabBar(
                  controller: _tabController,
                  onTap: (index) {
                    _onTabChanged();
                  },
                  labelColor: ColorResources.primaryColor,
                  unselectedLabelColor: Colors.white,
                  indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(25 / 2)),
                  ),
                  tabs: <Widget>[
                    _generateTabBarTextItem(AppTranslations.of(context).text(StringResources.new_)),
                    _generateTabBarTextItem(AppTranslations.of(context).text(StringResources.in_progress)),
                    _generateTabBarTextItem(AppTranslations.of(context).text(StringResources.completed)),
                    _generateTabBarTextItem(AppTranslations.of(context).text(StringResources.cancelled)),
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 200,
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  _generateOrderTabBloc(),
                  _generateOrderTabBloc(),
                  _generateOrderTabBloc(),
                  _generateOrderTabBloc(),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedIconTheme: IconThemeData(
          color: Colors.grey,
        ),
        selectedIconTheme: IconThemeData(color: ColorResources.primaryColor),
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        currentIndex: 1,
        selectedItemColor: ColorResources.primaryColor,
        selectedLabelStyle: TextStyle(color: ColorResources.primaryColor),
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
          _generateBottomNavigationBarItem(
            Icons.layers,
            AppTranslations.of(context).text(StringResources.services),
          ),
          _generateBottomNavigationBarItem(
            Icons.shopping_cart,
            AppTranslations.of(context).text(StringResources.myOrders),
          ),
          _generateBottomNavigationBarItem(
            Icons.more_horiz,
            AppTranslations.of(context).text(StringResources.more),
          ),
        ],
      ),
    );
  }

  _generateBottomNavigationBarItem(icon, text) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
      ),
      title: Text(
        text,
      ),
    );
  }

  _generateTabBarTextItem(text) {
    return Container(
      width: MediaQuery.of(context).size.width / 5,
      height: 25,
      child: Center(
        child: FittedBox(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  _generateOrderTabBloc() {
    return SingleChildScrollView(
      child: BlocBuilder<OrderListBloc, OrderListState>(
        builder: (context, state) {
          if (state is Loading) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is Loaded) {
            return Column(
                children: state.orders
                    .map((order) => OrderItem(
                          order: order,
                          onOrderChagned: () {
                            Navigator.pop(context);
                            switch (currentIndex) {
                              case 0:
                                orderListBloc.add(GetOrders(OrderStatus.ALL));
                                break;
                              case 1:
                                orderListBloc.add(GetOrders(OrderStatus.NEW));
                                break;
                              case 2:
                                orderListBloc
                                    .add(GetOrders(OrderStatus.IN_PROGRESS));
                                break;
                              case 3:
                                orderListBloc
                                    .add(GetOrders(OrderStatus.COMPLETED));
                                break;
                            }
                          },
                        ))
                    .toList());
          }
          return Container(
              child: FittedBox(
                child: Center(
                    child: Text(
                      AppTranslations.of(context).text(StringResources.no_order_found),
            style: TextStyle(
                fontSize: 18,
            ),
          )),
              ));
        },
      ),
    );
  }
}

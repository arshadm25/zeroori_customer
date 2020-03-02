import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeroori_customer/bloc/order_list_bloc/bloc.dart';
import 'package:zeroori_customer/pages/BasePage.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/resources/string_resources.dart';
import 'package:zeroori_customer/services/order_services.dart';
import 'package:zeroori_customer/widgets/order_item.dart';

class MyOrdersPage extends StatefulWidget {
  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  OrderListBloc orderListBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    orderListBloc = BlocProvider.of<OrderListBloc>(context);
    orderListBloc.add(GetOrders(OrderStatus.ALL));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,

      length: 4,
      child: BasePage(
        hasBack: false,
        title: "My Orders",
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
                    onTap: (index){
                      switch(index){
                        case 0:
                          orderListBloc.add(GetOrders(OrderStatus.ALL));
                          break;
                        case 1:
                          orderListBloc.add(GetOrders(OrderStatus.NEW));
                          break;
                        case 2:
                          orderListBloc.add(GetOrders(OrderStatus.IN_PROGRESS));
                          break;
                        case 3:
                          orderListBloc.add(GetOrders(OrderStatus.COMPLETED));
                          break;
                      }
                    },
                    labelColor: ColorResources.primaryColor,
                    unselectedLabelColor: Colors.white,
                    indicator: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25 / 2)),
                    ),
                    tabs: <Widget>[
                      _generateTabBarTextItem("All"),
                      _generateTabBarTextItem("New"),
                      _generateTabBarTextItem("In Progress"),
                      _generateTabBarTextItem("Completed"),
                    ],
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height-200,
                child: TabBarView(
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
          selectedIconTheme: IconThemeData(
            color: ColorResources.primaryColor
          ),
          unselectedLabelStyle: TextStyle(
            color: Colors.grey
          ),
          currentIndex: 1,
          selectedItemColor: ColorResources.primaryColor,
          selectedLabelStyle: TextStyle(
            color: ColorResources.primaryColor
          ),
          onTap: (index){
            switch(index){
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
              "Services",
            ),
            _generateBottomNavigationBarItem(
              Icons.shopping_cart,
              "My Orders",
            ),
            _generateBottomNavigationBarItem(
              Icons.more_horiz,
              "More",
            ),
          ],
        ),
      ),
    );
  }

  _generateBottomNavigationBarItem(icon, text) {
    return BottomNavigationBarItem(
      icon: Icon(icon,),
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
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  _generateOrderTabBloc(){
    return SingleChildScrollView(
      child: BlocBuilder<OrderListBloc,OrderListState>(
        builder: (context,state){
          if(state is Loading){
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if(state is Loaded){
            return Column(
                children: state.orders.map((order)=>OrderItem(
                  order: order,
                )).toList()
            );
          }
          return Container(
              child:Center(
                  child:Text("No Orders found")
              )
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeroori_customer/bloc/connectivity/bloc.dart';
import 'package:zeroori_customer/bloc/order_list_bloc/bloc.dart';
import 'package:zeroori_customer/bloc/service_bloc/bloc.dart';
import 'package:zeroori_customer/bloc/slider_bloc/bloc.dart';
import 'package:zeroori_customer/bloc/sub_service_bloc/bloc.dart';
import 'package:zeroori_customer/bloc/user/bloc.dart';
import 'package:zeroori_customer/pages/about_service.dart';
import 'package:zeroori_customer/pages/area_selection_page.dart';
import 'package:zeroori_customer/pages/change_password_page.dart';
import 'package:zeroori_customer/pages/confirm_page.dart';
import 'package:zeroori_customer/pages/describe_problem_page.dart';
import 'package:zeroori_customer/pages/edit_profile_page.dart';
import 'package:zeroori_customer/pages/fill_order_page.dart';
import 'package:zeroori_customer/pages/forgot_password_page.dart';
import 'package:zeroori_customer/pages/front_page.dart';
import 'package:zeroori_customer/pages/image_page.dart';
import 'package:zeroori_customer/pages/mail_us_page.dart';
import 'package:zeroori_customer/pages/map_selection_page.dart';
import 'package:zeroori_customer/pages/my_orders_page.dart';
import 'package:zeroori_customer/pages/my_profile.dart';
import 'package:zeroori_customer/pages/my_sevice_page.dart';
import 'package:zeroori_customer/pages/no_offers_page.dart';
import 'package:zeroori_customer/pages/notifications_page.dart';
import 'package:zeroori_customer/pages/order_detail_page.dart';
import 'package:zeroori_customer/pages/report_page.dart';
import 'package:zeroori_customer/pages/select_language_page.dart';
import 'package:zeroori_customer/pages/sign_in_page.dart';
import 'package:zeroori_customer/pages/sign_up_page.dart';
import 'package:zeroori_customer/pages/splash_screen.dart';
import 'package:zeroori_customer/pages/sub_category_page.dart';
import 'package:zeroori_customer/pages/time_selection_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ConnectivityBloc>(
          create:(context)=>ConnectivityBloc(),
        ),
        BlocProvider<UserBloc>(
          create:(context)=>UserBloc(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
//      localizationsDelegates: [
//        GlobalMaterialLocalizations.delegate,
//        GlobalMaterialLocalizations.delegate,
//      ],
//      supportedLocales: [
//        const Locale('en'),
//        const Locale('ar'),
//      ],
          title: 'Zeroori',
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          home: SplashScreen(),
          routes: {
            'front_page': (context) => FrontPage(),
            'login': (context) => SignInPage(),
            'register': (context) => SignUpPage(),
            'forgot': (context) => ForgotPassworedPage(),
            'change_password': (context) => ChangePassworedPage(),
            'services': (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider<SliderListBloc>(
                        create: (context) => SliderListBloc()),
                    BlocProvider<ServiceListBloc>(
                        create: (context) => ServiceListBloc())
                  ],
                  child: MyServicePage(),
                ),
            'notification': (context) => NotificationsPage(),
            'sub_category': (context) => BlocProvider<SubServiceListBloc>(
                create: (context)=>SubServiceListBloc(),
                child: SubCategoryPage(),
            ),
            'my_orders': (context) => BlocProvider<OrderListBloc>(
                create: (context)=>OrderListBloc(),
                child: MyOrdersPage(),
            ),
            'fill_order': (context) => FillOrderPage(),
            'select_area': (context) => AreaSelectionPage(),
            'select_map': (context) => MapSelectionPage(),
            'describe_problem': (context) => DescribeProblemPage(),
            'select_date': (context) => TimeSelectionPage(),
            'select_image': (context) => ImagePage(),
            'confirm': (context) => ConfirmPage(),
            'my_profile': (context) => MyProfilePage(),
            'order_details': (context) => OrderDetailPage(),
            'report': (context) => ReportPage(),
            'offer': (context) => NoOffersPage(),
            'edit': (context) => EditProfilePage(),
            'language': (context) => SelectLanguagePage(),
            'email': (context) => MailUsPage(),
            'about': (context) => AboutPage(),
          }),
    );
  }
}

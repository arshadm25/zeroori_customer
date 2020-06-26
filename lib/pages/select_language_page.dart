import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeroori_customer/bloc/language/language_bloc.dart';
import 'package:zeroori_customer/bloc/language/language_events.dart';
import 'package:zeroori_customer/bloc/service_bloc/service_list_bloc.dart';
import 'package:zeroori_customer/bloc/slider_bloc/slider_list_bloc.dart';
import 'package:zeroori_customer/pages/my_sevice_page.dart';
import 'package:zeroori_customer/pages/sign_in_page.dart';
import 'package:zeroori_customer/resources/color_resources.dart';
import 'package:zeroori_customer/resources/string_resources.dart';
import 'package:zeroori_customer/utils/app_translations.dart';

import 'front_page.dart';

class SelectLanguagePage extends StatefulWidget {
  final bool hasBack;

  const SelectLanguagePage({Key key, this.hasBack:true}) : super(key: key);

  @override
  _SelectLanguagePageState createState() => _SelectLanguagePageState();
}

class _SelectLanguagePageState extends State<SelectLanguagePage> {
  LanguageBloc languageBloc;

  @override
  void didChangeDependencies() {
    languageBloc = BlocProvider.of<LanguageBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.secondaryColor,
      appBar: AppBar(
        leading: Container(),
        centerTitle: true,
        backgroundColor: ColorResources.primaryColor,
        title: Text(AppTranslations.of(context)
            .text(StringResources.select_language)
            .toUpperCase()),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _generateLanguageItem(
              ColorResources.primaryColor,
              AppTranslations.of(context).text(StringResources.en),
              Colors.white,
              onLanguageChange: () {
                languageBloc.add(LanguageChanged("en"));
                if (!widget.hasBack) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FrontPage()));
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider<SliderListBloc>(
                        create: (context) => SliderListBloc(),
                        child: MultiBlocProvider(
                          providers: [
                            BlocProvider<SliderListBloc>(
                                create: (context) => SliderListBloc()),
                            BlocProvider<ServiceListBloc>(
                                create: (context) => ServiceListBloc())
                          ],
                          child: MyServicePage(),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 25),
            _generateLanguageItem(
              Colors.white,
              "عربى",
              ColorResources.primaryColor,
              onLanguageChange: () {
                languageBloc.add(LanguageChanged("ar"));
                if (!widget.hasBack) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FrontPage()));
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider<SliderListBloc>(
                        create: (context) => SliderListBloc(),
                        child: MultiBlocProvider(
                          providers: [
                            BlocProvider<SliderListBloc>(
                                create: (context) => SliderListBloc()),
                            BlocProvider<ServiceListBloc>(
                                create: (context) => ServiceListBloc())
                          ],
                          child: MyServicePage(),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  _generateLanguageItem(color, language, textColor,
      {VoidCallback onLanguageChange}) {
    return InkWell(
      onTap: onLanguageChange,
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          width: MediaQuery.of(context).size.width / 4.6,
          height: MediaQuery.of(context).size.width / 4.6,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: ColorResources.primaryColor),
          ),
          child: Center(
            child: FittedBox(
              child: Text(
                language,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

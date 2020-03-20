import 'dart:async';
import 'dart:core';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zeroori_customer/resources/string_resources.dart';
import 'language_events.dart';
import 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {

  LanguageBloc();

  @override
  LanguageState get initialState => AppLanguageState('en');

  @override
  Stream<LanguageState> mapEventToState(
      LanguageEvent event,
      ) async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (event is LanguageChanged) {
      try {
//        prefs.clear();
        prefs.setString(SharedResources.LANGUAGE, event.language);
//        application.onLocaleChanged(Locale(event.language,""));
        yield AppLanguageState(event.language);
      } catch (ex){
        String lang = prefs.getString(SharedResources.LANGUAGE);
        yield AppLanguageState(event.language);
      }
    }
  }
}



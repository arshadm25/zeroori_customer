import 'dart:async';
import 'dart:core';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zeroori_customer/resources/string_resources.dart';

import 'user_events.dart';
import 'user_states.dart';

class UserBloc extends Bloc<UserEvent, UserState> {

  UserBloc();

  @override
  UserState get initialState => AppInitialState();

  @override
  Stream<UserState> mapEventToState(
      UserEvent event,
      ) async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (event is LogIn) {
      try {
        prefs.clear();
        prefs.setBool(SharedResources.IS_LOGGED_IN, true);
        prefs.setInt(
            SharedResources.USER_ID, event.id);
        prefs.setString(SharedResources.USER, event.userJson);
        yield LoggedInState(true,event.userJson,event.id);
      } catch (ex){
        yield LoggedOutState();
      }
    }
    if (event is LogOut) {
        prefs.clear();
        prefs.setBool(SharedResources.IS_LOGGED_IN, false);
        yield LoggedOutState();
    }
    if(event is AppInitial){
      if(prefs.getBool(SharedResources.IS_LOGGED_IN)){
        yield LoggedInState(true,prefs.getString(SharedResources.USER),prefs.getInt(SharedResources.USER_ID));
      }else{
        yield LoggedOutState();
      }
    }
  }
}



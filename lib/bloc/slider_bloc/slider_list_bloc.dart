import 'dart:async';
import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:zeroori_customer/bloc/slider_bloc/slider_list_event.dart';
import 'package:zeroori_customer/bloc/slider_bloc/slider_list_state.dart';
import 'package:zeroori_customer/services/slider_service.dart';

class SliderListBloc extends Bloc<SliderListEvent, SliderListState> {
  SliderListBloc();

  @override
  SliderListState get initialState => Empty();

  @override
  Stream<SliderListState> mapEventToState(
    SliderListEvent event,
  ) async* {
    yield Loading();
    if (event is GetSliders) {
      try {
        final List sliders = await SliderService.getSliders();

        if (sliders.length > 0) {
          yield Loaded(sliders);
        } else {
          yield Empty();
        }
      } catch (ex) {
        yield Error(ex.toString());
      }
    }
  }
}

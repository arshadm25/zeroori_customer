import 'package:equatable/equatable.dart';

abstract class SliderListEvent extends Equatable {
  const SliderListEvent();
}

class GetSliders extends SliderListEvent {
  GetSliders();

  @override
  List<Object> get props => [];
}

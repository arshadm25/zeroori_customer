
import 'package:equatable/equatable.dart';
import 'package:zeroori_customer/models/slider.dart';

abstract class SliderListState extends Equatable {
  const SliderListState();
}

class Empty extends SliderListState {
  @override
  List<Object> get props => [];
}

class Loading extends SliderListState{

  @override
  List<Object> get props => [];
  
}

class Loaded extends SliderListState{
  final List<Slider> sliders;

  Loaded(this.sliders);
  
  @override
  List<Object> get props => [sliders];
}

class Error extends SliderListState{
  final String message;

  Error(this.message);

  @override
  List<Object> get props => [message];
}
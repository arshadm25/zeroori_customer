import 'package:equatable/equatable.dart';

abstract class LanguageEvent extends Equatable {
  const LanguageEvent();
}

class LanguageChanged extends LanguageEvent {
  String language;

  LanguageChanged(this.language);

  @override
  List<Object> get props => [language];
}
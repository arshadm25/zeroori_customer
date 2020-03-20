import 'package:equatable/equatable.dart';

abstract class LanguageState extends Equatable {
  const LanguageState();
}

class AppLanguageState extends LanguageState {
  final String language;

  AppLanguageState(this.language);

  @override
  List<Object> get props => [language];
}
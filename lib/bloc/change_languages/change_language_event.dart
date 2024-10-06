part of 'change_language_bloc.dart';

abstract class ChangeLanguageEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadSavedLanguage extends ChangeLanguageEvent {
  LoadSavedLanguage();
}

class ChangeLanguage extends ChangeLanguageEvent{
  final BuildContext context;
  ChangeLanguage({required this.context});
}

class ChangeLanguageCode extends ChangeLanguageEvent{
  final String language;
  ChangeLanguageCode({required this.language});
}

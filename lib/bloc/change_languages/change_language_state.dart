part of 'change_language_bloc.dart';

class ChangeLanguageState extends Equatable {
  final Locale locale;
  final String? selectedLanguageCode;
  final bool isLoading;
  const ChangeLanguageState(
      {this.locale = const Locale("en"),
      this.selectedLanguageCode,
      this.isLoading = false});

  ChangeLanguageState copyWith(
      {Locale? locale, String? selectedLanguageCode, bool? isLoading}) {
    return ChangeLanguageState(
      locale: locale ?? this.locale,
      selectedLanguageCode: selectedLanguageCode ?? this.selectedLanguageCode,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [locale, selectedLanguageCode, isLoading];
}

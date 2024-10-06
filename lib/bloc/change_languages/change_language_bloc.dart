import 'package:flutter/material.dart' show Locale;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:my_app/extension/localization_extension.dart';
import 'package:my_app/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

part "change_language_event.dart";
part "change_language_state.dart";

class ChangeLanguageBloc
    extends Bloc<ChangeLanguageEvent, ChangeLanguageState> {
  ChangeLanguageBloc() : super(const ChangeLanguageState()) {
    on<LoadSavedLanguage>(_loadSavedLanguage);
    on<ChangeLanguage>(_changeLanguage);
    on<ChangeLanguageCode>(_changeLanguageCode);
  }

  // Loads saved language from SharedPreferences
  Future<void> _loadSavedLanguage(
      LoadSavedLanguage event, Emitter<ChangeLanguageState> emit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? language = prefs.getString('language');
    if (language != null) {
      emit(state.copyWith(
          locale: Locale(language), selectedLanguageCode: language));
    } else {
      emit(state.copyWith(
          locale: const Locale("en"), selectedLanguageCode: "en"));
    }
  }

  // Changes the language and saves it
  Future<void> _changeLanguage(
      ChangeLanguage event, Emitter<ChangeLanguageState> emit) async {
    emit(state.copyWith(isLoading: true));

    await Future.delayed(const Duration(seconds: 3));

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check if selectedLanguageCode is null
    if (state.selectedLanguageCode != null) {
      await prefs.setString('language', state.selectedLanguageCode!);

      emit(const ChangeLanguageState().copyWith(
        locale: Locale(state.selectedLanguageCode!),
        selectedLanguageCode: state.selectedLanguageCode,
        isLoading: false,
      ));
      Utils.showToast(
          event.context.localizations!.language_has_been_changed_successfully);
    } else {
      // Handle the case where selectedLanguageCode is null
      emit(state.copyWith(isLoading: false));
      // Optionally, you could log the error or throw an exception
    }
  }

  // Change The Language Code
  _changeLanguageCode(
      ChangeLanguageCode event, Emitter<ChangeLanguageState> emit) {
    emit(state.copyWith(selectedLanguageCode: event.language));
  }
}

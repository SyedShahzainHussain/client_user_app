part of 'check_authentiaction_bloc.dart';

sealed class CheckAuthentiactionState extends Equatable {
  const CheckAuthentiactionState();
  
  @override
  List<Object> get props => [];
}

final class CheckAuthentiactionInitial extends CheckAuthentiactionState {}

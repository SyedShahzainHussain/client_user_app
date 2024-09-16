part of 'check_authentiaction_bloc.dart';

abstract class CheckAuthentiactionEvent extends Equatable {
  const CheckAuthentiactionEvent();

  @override
  List<Object> get props => [];
}

class CheckAuthentiaction extends CheckAuthentiactionEvent {
  final BuildContext context;
  const CheckAuthentiaction(this.context);
}

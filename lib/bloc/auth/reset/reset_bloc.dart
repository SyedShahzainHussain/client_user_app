import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/bloc/auth/forgot/forgot_bloc.dart';
import 'package:my_app/bloc/auth/reset/reset_event.dart';
import 'package:my_app/bloc/auth/reset/reset_state.dart';
import 'package:my_app/enums/enums.dart';
import 'package:my_app/repository/auth/auth_api_repository.dart';

class ResetBloc extends Bloc<ResetEvent, ResetState> {
  final AuthApiRepository apiRepository;
  ResetBloc({required this.apiRepository}) : super(const ResetState()) {
    on<ResetApiEvent>(_resetApiEvent);
  }

  _resetApiEvent(ResetApiEvent event, Emitter<ResetState> emit) async {
    final forgot = BlocProvider.of<ForgotBloc>(event.context).state;
    final body = {"password": forgot.password, "code": forgot.otp.toString()};
    emit(state.copyWith(postApiStatus: PostApiStatus.loading, message: ""));
    await apiRepository.resetPassword(body).then((value) {
      emit(state.copyWith(
          message: "Reset Password Successfully",
          postApiStatus: PostApiStatus.success));
    }).onError((error, _) {
      emit(state.copyWith(
          message: error.toString(), postApiStatus: PostApiStatus.error));
    });
  }
}

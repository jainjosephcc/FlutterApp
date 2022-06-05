import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preparedacademy/auth/login/login_event.dart';
import 'package:preparedacademy/auth/login/login_state.dart';

import '../auth_repository.dart';
import '../form_submission_status.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>
{
  final AuthRepository authRepo;

  LoginBloc({required this.authRepo})
      : super(LoginState()) {
    on<LoginEvent>(_onEvent);
  }

  Future<void> _onEvent(LoginEvent event, Emitter<LoginState> emit) async {
    if (event is LoginEmailChanged) {
      emit(state.copyWith(email: event.email));
    }
    // password update
    else if (event is LoginPasswordChanged) {
      emit(state.copyWith(password: event.password));
    }
    //form submitted
    else if (event is LoginSubmitted) {
      emit(state.copyWith(formStatus: FormSubmitting()));

      try {
        await authRepo.login();
        emit(state.copyWith(formStatus: SubmissionSuccess()));
      } catch (error) {
         emit(state.copyWith(formStatus: SubmissionFailed(error.toString())));
      }
    }
  }
}
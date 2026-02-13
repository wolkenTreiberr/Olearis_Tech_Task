import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:olearis_tech_task/repositories/auth/auth_repository.dart';
import 'package:olearis_tech_task/utils/result.dart';

import 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const SignInState());

  final AuthRepository _authRepository;

  void updateLogin(String value) {
    emit(state.copyWith(login: value));
  }

  void updatePassword(String value) {
    emit(state.copyWith(password: value));
  }

  Future<void> signIn() async {
    emit(state.copyWith(isLoading: true));
    final result = await _authRepository.signIn(
      login: state.login,
      password: state.password,
    );
    if (isClosed) return;
    switch (result) {
      case Success():
        emit(state.copyWith(isLoading: false));
      case Failure(:final message):
        emit(state.copyWith(isLoading: false, error: message));
    }
  }
}

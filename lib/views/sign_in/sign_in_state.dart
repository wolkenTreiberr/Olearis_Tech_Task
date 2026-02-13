class SignInState {
  const SignInState({
    this.login = '',
    this.password = '',
    this.isLoading = false,
    this.error,
  });

  final String login;
  final String password;
  final bool isLoading;
  final String? error;

  bool get isValid => login.isNotEmpty && password.isNotEmpty;

  SignInState copyWith({
    String? login,
    String? password,
    bool? isLoading,
    String? error,
  }) {
    return SignInState(
      login: login ?? this.login,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

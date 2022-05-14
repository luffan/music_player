class SignInState {
  final String email;
  final String password;
  final bool completed;

  SignInState({
    required this.email,
    required this.password,
    required this.completed,
  });

  SignInState copyWith({
    String? email,
    String? password,
    bool? completed,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      completed: completed ?? this.completed,
    );
  }
}

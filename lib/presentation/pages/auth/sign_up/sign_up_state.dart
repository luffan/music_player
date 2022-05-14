class SignUpState {
  final String name;
  final String email;
  final String password;
  final bool completed;

  SignUpState({
    required this.name,
    required this.email,
    required this.password,
    required this.completed,
  });

  SignUpState copyWith({
    String? name,
    String? email,
    String? password,
    bool? completed,
  }) {
    return SignUpState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      completed: completed ?? this.completed,
    );
  }
}

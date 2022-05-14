class AppState {
  final bool hasUser;

  const AppState({
    required this.hasUser,
  });

  AppState copyWith({
    bool? hasUser,
  }) {
    return AppState(hasUser: hasUser ?? this.hasUser);
  }
}

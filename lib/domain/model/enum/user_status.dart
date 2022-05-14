enum UserStatus {
  none,
  listener,
  controller,
}

extension UserStatusExt on UserStatus {
  static UserStatus? getByName(String? type) {
    if (type == null) return null;

    return UserStatus.values
        .where((status) => status.name == type)
        .first;
  }
}
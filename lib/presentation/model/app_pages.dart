enum AppPages {
  app,
  profile,
  main,
  song,
  signIn,
  signUp,
  connected,
  search,
}

extension AppPagesExt on AppPages {
  static AppPages? getByName(String? type) {
    if (type == null) return null;

    return AppPages.values
        .where((page) => page.name == type)
        .first;
  }
}
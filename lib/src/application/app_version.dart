
enum AppVersion {
  unknown,

  /// if user using the same version as current app version
  upToDate,

  /// when the version is old
  old,

  ///got update version but user can keep it
  gotNewRelease,

  /// force user to download new version
  majorUpdate,

  /// force user to download new version
  unstable,
}

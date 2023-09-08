import '../domain/models/patch_info.dart';
//TODO: will work on this later
class AppState {
  AppState.init()
      : patchInfo = null,
        isLoading = false,
        lastError = '';

  AppState.loading()
      : patchInfo = null,
        lastError = '',
        isLoading = true;

  AppState.loaded({
    required this.patchInfo,
  })  : isLoading = true,
        lastError = '';

  AppState.error(this.lastError)
      : isLoading = false,
        patchInfo = null;

  final PatchInfo? patchInfo;
  final bool isLoading;
  final String lastError;

  bool get hasError => lastError.isNotEmpty;
}

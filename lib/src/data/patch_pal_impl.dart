import 'package:flutter/foundation.dart';

import '../../patch_pal.dart';
import '../domain/repository/update_notifier_repo.dart';
import 'patch_repo_impl.dart';

/// `PatchPalImplement` is the implementation of [PatchPal]. This class is intended for internal use by the PatchPal library and provides the core functionality required to manage patch information and updates.

/// **Note**: While this class is marked as `@protected`, it plays a vital role in the functionality of the PatchPal library.

@protected
class PatchPalImplement {
  /// Private constructor to ensure a singleton pattern.
  PatchPalImplement._();

  /// Singleton instance of PatchPalImplement.
  static final PatchPalImplement _instance = PatchPalImplement._();

  /// Factory method to obtain the singleton instance of PatchPalImplement.
  factory PatchPalImplement() => _instance;

  late String _configLocation;
  late PatchRepo _repo;

  late bool _isReady;
  PatchInfo? _patchInfo;
  PatchInfo? get data => _patchInfo;

  String _lastError = '';
  bool get hasError => _lastError.isNotEmpty;

  /// Initialize the PatchPalImplement with the provided [configLocation].
  /// This method sets up the implementation, checks for updates, and prepares it for use.
  ///
  /// Parameters:
  /// - `configLocation`: The location of the JSON configuration or gist file containing patch-related information.
  ///
  /// **Returns**: A future that completes when the initialization is successful or throws an exception if an error occurs during setup.
  Future<void> init(String configLocation) async {
    _isReady = false;
    _configLocation = configLocation;
    _repo = PatchRepoImpl(configLocation: _configLocation);

    try {
      final value = await _repo.checkUpdate();
      _patchInfo = value;
      _isReady = true;
    } catch (e) {
      debugPrint(e.toString());
      _lastError = e.toString();
      rethrow;
    }
  }

  /// Indicates whether the PatchPalImplement is ready for use.
  bool get isReady => _isReady;

  /// Retrieve a specific patch item by its [name].
  ///
  /// Parameters:
  /// - `name`: The name of the patch item to retrieve.
  ///
  /// **Returns**: The requested [PatchItem] or `null` if the item is not found.
  PatchItem? getItem(String name) {
    try {
      return _patchInfo?.items.firstWhere((element) => element.name == name);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}

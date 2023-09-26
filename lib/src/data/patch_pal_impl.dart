import 'package:flutter/foundation.dart';

import '../../patch_pal.dart';
import '../domain/repository/update_notifier_repo.dart';
import 'patch_repo_impl.dart';

///
/// PatchPalImplement is the implementation of [PatchPal]
/// It is used internally by [PatchPal]
@protected
class PatchPalImplement {
  PatchPalImplement._();
  static final PatchPalImplement _instance = PatchPalImplement._();

  factory PatchPalImplement() => _instance;

  late String _configLocation;
  late PatchRepo _repo;

  late bool _isReady;
  PatchInfo? _patchInfo;
  PatchInfo? get data => _patchInfo;

  String _lastError = '';
  bool get hasError => _lastError.isNotEmpty;

  Future<void> setUp(String configLocation) async {
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

  bool get isReady => _isReady;

  PatchItem? getItem(String name) {
    try {
      return _patchInfo?.items.firstWhere((element) => element.name == name);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}

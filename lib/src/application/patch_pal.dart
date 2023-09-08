import 'dart:async';

import 'package:flutter/material.dart';
import '../domain/models/patch_info.dart';

import '../data/patch_repo_impl.dart';
import '../domain/models/patch_item.dart';

import '../domain/repository/update_notifier_repo.dart';

abstract interface class IPatcher {
  Future<void> setUp(String configLocation);
  bool get isReady;

  /// Returns the patch item from the given name.
  /// Returns null if the patch item is not found.
  PatchItem? getItem(String name);
}

class PatchPal implements IPatcher {
  PatchPal._();
  static final PatchPal _instance = PatchPal._();
  factory PatchPal() => _instance;

  late String _configLocation;
  late PatchRepo _repo;

  late bool _isReady;
  PatchInfo? _patchInfo;
  PatchInfo? get data => _patchInfo;

  String _lastError = '';
  bool get hasError => _lastError.isNotEmpty;

  @override
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

  @override
  bool get isReady => _isReady;

  @override
  PatchItem? getItem(String name) {
    try {
      return _patchInfo?.items.firstWhere((element) => element.name == name);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}

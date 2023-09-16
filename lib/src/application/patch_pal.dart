import 'dart:async';

import '../data/patch_pal_impl.dart';
import '../domain/models/patch_info.dart';

import '../domain/models/patch_item.dart';

/// PatchPal is the main class for the patch pal library.
/// It provides the patch info and patch items.
abstract class PatchPal {
  static final PatchPalImplement _impl = PatchPalImplement();

  static Future<void> setUp(String configLocation) async {
    await _impl.setUp(configLocation);
  }

  static bool get isReady => _impl.isReady;

  /// Returns the patch item from the given name.
  /// Returns null if the patch item is not found.
  static PatchItem? getItem(String name) => _impl.getItem(name);

  /// Returns the patch info.
  /// Returns null if the patch info is not found.
  static PatchInfo? get data => _impl.data;
}

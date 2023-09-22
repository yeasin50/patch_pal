import 'dart:async';

import 'package:flutter/material.dart';

import '../data/patch_pal_impl.dart';
import '../domain/models/patch_info.dart';

import '../domain/models/patch_item.dart';
import '../presentation/presentation.dart';

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

  ///*  Presentation
  ///*  ============
  ///*  The following methods are presentation methods.
  ///*  They are used to show a widget or overlay if the patch item is found and value is true.
  ///*  Else they return the child widget.

  /// show dialog if patch item is found and value is true
  static Future<void> dialog({
    required BuildContext context,
    required String patchItemName,
    String? title,
    String? message,
    String? positiveText,
    String? negativeText,
    VoidCallback? onPositive,
    VoidCallback? onNegative,
  }) async {
    Future<void> _dialog() async {
      await showPatchAlert(
        context: context,
        patchItemName: patchItemName,
        title: title,
        message: message,
        positiveText: positiveText,
        negativeText: negativeText,
        onPositive: onPositive,
        onNegative: onNegative,
      );
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async => await _dialog());
  }

  ///return a overlay if patch item is found and value is true
  ///else returns the [child] widget or [SizedBox.shrink()]
  static Widget view({
    required String patchItemName,
    Widget? onPositive,
    required Widget child,
  }) {
    return onTrue(
      patchItemName: patchItemName,
      child: child,
      onPositive: onPositive,
    );
  }

  static Widget overlay({
    required String patchItemName,
    Widget? overlay,
    Alignment? alignment,
    required Widget child,
  }) {
    return patchOverlay(
      patchItemName: patchItemName,
      child: child,
      overlay: overlay,
      alignment: alignment,
    );
  }

  ///*  PatcherView
  /// show a widget if patch item is found and value is true
  /// else returns the [child] widget or [SizedBox.shrink()]
  /// if [tristate] is true, then returns the [onNoPatch] widget if the patch item is not found.
  static Widget switcher({
    required String patchItemName,
    Widget? onPatch,
    required Widget onNoPatch,
    bool tristate = false,
  }) {
    return PatchSwitcher(
      patchItemName: patchItemName,
      onPatch: onPatch,
      onNoPatch: onNoPatch,
      tristate: tristate,
    );
  }
}

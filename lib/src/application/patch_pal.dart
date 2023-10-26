import 'dart:async';

import 'package:flutter/material.dart';

import '../data/patch_pal_impl.dart';
import '../domain/models/patch_info.dart';

import '../domain/models/patch_item.dart';
import '../presentation/presentation.dart';

/// `PatchPal` is a core class in the Patch Pal library, providing access to patch information and presentation methods.
///
/// ## Getting Started
/// To use PatchPal, you should call `setUp` to configure the library before using any other features. The `configLocation` parameter should point to the location of a JSON configuration or gist file hosted online, which contains patch-related information.
///
/// ```dart
/// await PatchPal.setUp(configLocation);
/// ```
///
/// ## Accessing Patch Info
/// The class offers access to patch information and patch items through the following methods:
///
/// - `getItem(String name)`: Retrieve a specific patch item by its name. Returns `null` if not found.
/// - `data`: Get the patch info. Returns `null` if not found.
///
/// Example:
/// ```dart
/// PatchItem? item = PatchPal.getItem('patchItemName');
/// PatchInfo? info = PatchPal.data;
/// ```
///
/// ## Presentation Methods
/// The class provides presentation methods for showing widgets or overlays based on the presence and value of patch items.
/// These methods help you display content conditionally and gracefully in your Flutter app.
///
/// ### `dialog`
/// Display a dialog if the specified patch item is found and its value is `true`.
///
/// ### `view`
/// Return a widget overlay if the patch item is found and its value is `true`. Otherwise, return the provided child widget.
///
/// ### `overlay`
/// Display an overlay widget if the patch item is found and its value is `true`. Otherwise, display the provided child widget.
///
/// ### `switcher`
/// Show a widget if the patch item is found and its value is `true`. Otherwise, return the provided child widget. If `tristate` is `true`, you can specify the `onNoPatch` widget to be shown when the patch item is not found.
///
/// Please note that these methods work with the Patch Pal library's internal logic and require the library to be correctly configured via `setUp` for effective use.
///
/// Example:
/// ```dart
/// PatchPal.dialog(
///   context: context,
///   patchItemName: 'exampleItem',
///   title: 'Dialog Title',
///   message: 'Dialog Message',
///   positiveText: 'OK',
///   onPositive: () {
///     // Positive action
///   },
///   onNegative: () {
///     // Negative action
///   },
/// );
/// ```
///
/// ## Notes
/// - Ensure that `PatchPal.init(jsonConfigURL)` is called before using any other methods in the `PatchPal` class.
/// - The presentation methods are designed to be user-friendly and integrate seamlessly into your Flutter app.
/// - Customize the behavior of the presentation methods by providing the necessary parameters.
/// - Make sure to import the required Flutter libraries for widgets and UI elements as needed.
///
abstract class PatchPal {
  static final PatchPalImplement _impl = PatchPalImplement();

  /// Initialize the PatchPal library with the provided [configLocation]. This method sets up the library and prepares it for use by internally calling `_impl.init(configLocation)` to initialize the core implementation.
  ///
  /// Parameters:
  /// - `configLocation`: The location of the JSON configuration or gist file containing patch-related information.
  ///
  /// Returns a `Future` that completes when the library is successfully initialized or throws an exception if an error occurs during setup.
  ///
  /// Example:
  /// ```dart
  /// await PatchPal.init(
  ///   'https://raw.githubusercontent.com/yeasin50/AssetsFor_/master/apps/patch_pal/test.json',
  /// );
  /// ```
  ///
  /// **Note**: This method should be called before using any other features provided by the PatchPal library.
  ///
  static Future<void> init(String configLocation) async {
    await _impl.init(configLocation);
  }

  /// Indicates whether the PatchPal library is ready for use. It returns `true` when the library has been successfully initialized, and `false` if it is not yet ready or an error occurred during initialization.
  ///
  /// Usage:
  /// ```dart
  /// if (PatchPal.isReady) {
  ///   // Use PatchPal methods here.
  /// } else {
  ///   // Handle initialization failure.
  /// }
  /// ```
  static bool get isReady => _impl.isReady;

  /// Retrieve a specific patch item by its [name].
  ///
  /// Parameters:
  /// - `name`: The name of the patch item to retrieve.
  ///
  /// Returns: The requested [PatchItem] or `null` if the item is not found.
  ///
  /// Example:
  /// ```dart
  /// PatchItem? item = PatchPal.getItem('patchItemName');
  /// if (item != null) {
  ///   // Use the retrieved patch item here.
  /// } else {
  ///   // Handle the case where the item is not found.
  /// }
  /// ```
  static PatchItem? getItem(String name) => _impl.getItem(name);

  /// Retrieve the patch information.
  ///
  /// Returns: The [PatchInfo] object containing patch-related data or `null` if the patch info is not found.
  ///
  /// Example:
  /// ```dart
  /// PatchInfo? info = PatchPal.data;
  /// if (info != null) {
  ///   // Use the retrieved patch information here.
  /// } else {
  ///   // Handle the case where the patch info is not found.
  /// }
  /// ```
  static PatchInfo? get data => _impl.data;

  /// The `dialog` method displays a dialog if the specified patch item is found and its value is `true`. Otherwise, it returns the provided [child] widget or [SizedBox.shrink()].
  ///
  /// Use this method to conditionally show a dialog in your Flutter app based on the presence and value of a patch item.
  ///
  /// Example:
  /// ```dart
  /// await PatchPal.dialog(
  ///   context: context,
  ///   patchItemName: 'exampleItem',
  ///   title: 'Dialog Title',
  ///   message: 'Dialog Message',
  ///   positiveText: 'OK',
  ///   onPositive: () {
  ///     // Positive action
  ///   },
  ///   onNegative: () {
  ///     // Negative action
  ///   },
  /// );
  /// ```
  ///
  /// Parameters:
  /// - `context`: The `BuildContext` for displaying the dialog.
  /// - `patchItemName`: The name of the patch item to check.
  /// - `title`: Optional title for the dialog.
  /// - `message`: Optional message for the dialog.
  /// - `positiveText`: Optional text for the positive action button.
  /// - `negativeText`: Optional text for the negative action button.
  /// - `onPositive`: Callback function to execute when the positive action button is pressed.
  /// - `onNegative`: Callback function to execute when the negative action button is pressed.
  ///
  /// This method ensures that the dialog is shown after the build process is complete using `WidgetsBinding`.
  ///
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
    Future<void> dialog() async {
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

    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) async => await dialog());
  }

  /// Display an overlay widget if the specified patch item is found and its value is `true`. Otherwise, return the provided [child] widget. If [tristate] is `true`, display the [onPositive] widget when the patch item is found but its value is `false`.
  ///
  /// Use this method to conditionally display an overlay on top of a child widget based on the presence and value of a patch item in your Flutter app.
  ///
  /// Example:
  /// ```dart
  /// Widget content = PatchPal.view(
  ///   patchItemName: 'exampleItem',
  ///   onPositive: PositiveOverlayWidget(), // The overlay widget to display when 'exampleItem' is found but its value is `false`.
  ///   child: MyContentWidget(), // The base content widget.
  /// );
  /// ```
  ///
  /// Parameters:
  /// - `patchItemName`: The name of the patch item to check.
  /// - `onPositive`: The overlay widget to display when the patch item is found but its value is `false`. If not provided, no overlay is shown.
  /// - `child`: The base content widget that the overlay may be applied to.
  ///
  /// Returns a widget that displays the overlay on top of the child widget if the specified conditions are met.
  ///
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

  /// Display an overlay widget if the specified patch item is found and its value is `true`. Otherwise, display the provided [child] widget.
  ///
  /// Use this method to conditionally apply an overlay to a child widget based on the presence and value of a patch item in your Flutter app.
  ///
  /// Example:
  /// ```dart
  /// Widget content = PatchPal.overlay(
  ///   patchItemName: 'exampleItem',
  ///   overlay: MyOverlayWidget(), // The overlay widget to display if 'exampleItem' is found and `true`.
  ///   child: MyContentWidget(), // The base content widget.
  ///   alignment: Alignment.center, // Optional alignment for the overlay.
  /// );
  /// ```
  ///
  /// Parameters:
  /// - `patchItemName`: The name of the patch item to check.
  /// - `overlay`: The overlay widget to display if the patch item is found and `true`. If not provided, no overlay is shown.
  /// - `alignment`: Optional alignment for the overlay. Use the `Alignment` class to specify the alignment, e.g., `Alignment.center`. Default is `null`.
  /// - `child`: The base content widget that the overlay may be applied to.
  ///
  /// Returns a widget that displays the overlay on top of the child widget, respecting the specified alignment.
  ///
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

  /// Display a widget if the specified patch item is found and its value is `true`. Otherwise, return the provided [onNoPatch] widget.
  ///
  /// If [tristate] is set to `true`, the [onNoPatch] widget will be returned when the patch item is not found. If [tristate] is `false`, the [onNoPatch] widget is ignored, and an empty widget is returned.
  ///
  /// Use this method to conditionally render content based on the presence and value of a patch item in your Flutter app.
  ///
  /// Example:
  /// ```dart
  /// Widget content = PatchPal.switcher(
  ///   patchItemName: 'exampleItem',
  ///   onPatch: MyWidget(), // The widget to display if 'exampleItem' is found and `true`.
  ///   onNoPatch: NoItemWidget(), // The fallback widget to display if 'exampleItem' is not found.
  ///   tristate: true, // Enable tristate behavior to show the fallback widget when 'exampleItem' is not found.
  /// );
  /// ```
  ///
  /// Parameters:
  /// - `patchItemName`: The name of the patch item to check.
  /// - `onPatch`: The widget to display if the patch item is found and `true`.
  /// - `onNoPatch`: The fallback widget to display if the patch item is not found (or when [tristate] is `true`).
  /// - `tristate`: Set to `true` to enable tristate behavior, or `false` to ignore the [onNoPatch] widget. Default is `false`.
  ///
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

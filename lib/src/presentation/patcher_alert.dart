import 'package:flutter/material.dart';

import '../../patch_pal.dart';

/// returns a [PatcherViewOnFalse] if the patch item is not found and
/// value is false.
class PatcherViewOnFalse2 extends StatelessWidget {
  const PatcherViewOnFalse2({
    super.key,
    required this.patchItemName,
    this.message,
    this.child,
  });

  final String patchItemName;

  final String _defaultMessage = 'This feature is not available right now.';

  /// The message to show if the patch item is not found.
  /// If not provided, the default message will be shown.
  final String? message;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final item = PatchPal.getItem(patchItemName);

    return item?.value == true ? child ?? Text(message ?? item?.message ?? _defaultMessage) : const SizedBox.shrink();
  }
}

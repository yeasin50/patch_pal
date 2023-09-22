import 'package:flutter/material.dart';

import '../../patch_pal.dart';

/// returns a Widget if the patch item is found and value is true.
/// else returns the [child] widget.
@protected
Widget onTrue({
  required String patchItemName,
  Widget? child,
  Widget? onPositive,
}) {
  final item = PatchPal.getItem(patchItemName);

  return item?.value == true
      ? onPositive ?? const Text('This feature is not available right now.')
      : child ?? const SizedBox.shrink();
}

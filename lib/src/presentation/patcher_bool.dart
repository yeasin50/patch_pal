import 'package:flutter/material.dart';

import '../../patch_pal.dart';

//TODO: add more customization options for Views
/// returns a [PatcherViewOnFalse] if the patch item is not found and
/// value is false.
class PatcherViewOnFalse extends StatelessWidget {
  const PatcherViewOnFalse({
    super.key,
    required this.patchItemName,
    this.message,
    this.onPositive,
  });

  final String patchItemName;

  final String _defaultMessage = 'This feature is not available right now.';

  /// The message to show if the patch item is not found.
  /// If not provided, the default message will be shown.
  final String? message;

  final Widget? onPositive;

  @override
  Widget build(BuildContext context) {
    final item = PatchPal().getItem(patchItemName);

    return item?.value == true ? 
         Text(message ?? item?.message ?? _defaultMessage) 
         : onPositive ?? const SizedBox.shrink();
  }
}

import 'package:flutter/material.dart';

import '../../patch_pal.dart';

@protected
class PatchSwitcher extends StatelessWidget {
  const PatchSwitcher({
    Key? key,
    required this.patchItemName,
    required this.tristate,
    this.onPatch,
    required this.onNoPatch,
  }) : super(key: key);

  final String patchItemName;

  ///if true, [onNoPatch] will be used when the patch item is not found
  final bool tristate;

  ///when the patch item is found and value is true
  final Widget? onPatch;

  ///when the patch item value is false
  /// if [tristate] is true, this will be used when the patch item is not found
  final Widget onNoPatch;

  @override
  Widget build(BuildContext context) {
    final item = PatchPal.getItem(patchItemName);

    return item != null
        ? item.value
            ? onPatch ??
                Text(item.message ?? 'This feature is not available right now.')
            : onNoPatch
        : tristate
            ? onNoPatch
            : const SizedBox.shrink();
  }
}

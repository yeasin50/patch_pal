import 'package:flutter/material.dart';

import '../../patch_pal.dart';

///show a overlay if patch item is found and value is true
@protected
Widget patchOverlay({
  required String patchItemName,
  required Widget child,
  Widget? overlay,
  Alignment? alignment,
}) {
  final item = PatchPal.getItem(patchItemName);

  if (item?.value == true) {
    return Stack(
      children: [
        child,
        Align(
          alignment: alignment ?? Alignment.center,
          child: overlay ?? Text(item?.message ?? 'This feature is not available right now.'),
        ),
      ],
    );
  } else {
    return child;
  }
}

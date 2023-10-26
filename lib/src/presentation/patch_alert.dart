import 'package:flutter/material.dart';

import '../../patch_pal.dart';

///show a alert dialog if patch item is found and value is true
@protected
Future<void> showPatchAlert({
  required BuildContext context,
  required String patchItemName,
  String? title,
  String? message,
  String? positiveText,
  String? negativeText,
  VoidCallback? onPositive,
  VoidCallback? onNegative,
}) async {
  final item = PatchPal.getItem(patchItemName);
  final content = Text(
      message ?? item?.message ?? 'This feature is not available right now.');

  if (item?.value == true) {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: Text(title ?? 'Alert'),
          content: content,
          actions: [
            TextButton(
              onPressed: onPositive ?? Navigator.of(context).pop,
              child: Text(positiveText ?? 'OK'),
            ),
            TextButton(
              onPressed: onNegative ?? Navigator.of(context).pop,
              child: Text(negativeText ?? 'Cancel'),
            ),
          ],
        );
      },
    );
  }
}

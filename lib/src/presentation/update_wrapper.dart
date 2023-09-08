import 'package:flutter/material.dart';

class PatchApp extends StatelessWidget {
  const PatchApp({
    super.key,
    required this.configLocation,
    this.child,
  });

  /// json raw location
  final String configLocation;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => child ?? const SizedBox.shrink(),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Patcher().setUp(
          'https://raw.githubusercontent.com/yeasin50/AssetsFor_/master/apps/patch_pal/test.json'),
      builder: builder,
    );
  }
}

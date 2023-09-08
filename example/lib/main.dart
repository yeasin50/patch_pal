import 'package:flutter/material.dart';
import 'package:patch_pal/patch_pal.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: PatchPal().setUp('https://raw.githubusercontent.com/yeasin50/AssetsFor_/master/apps/patch_pal/test.json'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error'),
            );
          } else {
            return const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Column(
                    children: [
                      PatcherViewOnFalse(
                        patchItemName: 'rain',
                        message: 'This feature is not available right now.',
                      ),
                      PatcherViewOnFalse(
                        patchItemName: 'unknown',
                        onPositive: Text('it is available now!'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

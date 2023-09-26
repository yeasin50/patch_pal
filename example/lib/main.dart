import 'package:flutter/material.dart';
import 'package:patch_pal/patch_pal.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: FutureBuilder<void>(
            future: PatchPal.setUp(
              'https://raw.githubusercontent.com/yeasin50/AssetsFor_/master/apps/patch_pal/test.json',
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error'),
                  );
                } else {
                  return Column(
                    children: [
                      buildPatchPalWidget(context),
                    ],
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Column buildPatchPalWidget(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        PatchPal.switcher(
          patchItemName: 'rain',
          onPatch: const Text('It is raining'),
          onNoPatch: const Text('This is a text'),
        ),
        PatchPal.switcher(
          patchItemName: 'rain',
          onNoPatch: const Text('This is a text'),
        ),
        PatchPal.switcher(
          patchItemName: 'unknown',
          onNoPatch: const Text('This is a text'),
          tristate: true,
        ),
        const Divider(),
        const Text("Overlay"),
        Container(
          height: 200,
          width: 200,
          color: Colors.red,
          child: PatchPal.overlay(
            patchItemName: 'rain',
            alignment: Alignment.bottomCenter,
            child: const Text('Beta test,raining'),
          ),
        ),
        const Divider(),
        const Text("Dialog"),
        Builder(builder: (ctx) {
          PatchPal.dialog(
            context: context,
            patchItemName: 'rain',
            title: 'Rain',
            message: 'It is raining',
            positiveText: 'Ok',
            negativeText: 'Cancel',
            onPositive: () {
              Navigator.pop(context);
            },
            onNegative: () {
              Navigator.pop(context);
            },
          );

          return const Text('auto show dialog');
        }),
        const Divider(),
        const Text("View"),
        PatchPal.view(
          patchItemName: 'rain',
          onPositive: const Text('It is raining'),
          child: const Text('This is a text'),
        ),
        PatchPal.view(
          patchItemName: 'rain',
          child: const Text('This is a text'),
        ),
        PatchPal.view(
          patchItemName: 'unknown',
          child: const Text('This is a text'),
        ),
      ],
    );
  }
}

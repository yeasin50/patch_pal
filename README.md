# PatchPal

[![Flutter CI](https://github.com/yeasin50/patch_pal/actions/workflows/flutter_test.yaml/badge.svg)](https://github.com/yeasin50/patch_pal/actions/workflows/flutter_test.yaml)

`patch_pal` is a Flutter package that enables you to easily enable or disable features in your app by utilizing a JSON configuration file. You can use either a Gist or a raw [Git JSON file](https://github.com/yeasin50/AssetsFor_/blob/master/apps/patch_pal/test.json).

## Table of Contents

- [Getting Started](#getting-started)
- [JSON Structure](#json-structure)
- [Usage](#usage)
- [TODO List](#todo-list)

## Getting Started

Before you begin, make sure you have a JSON configuration file prepared. The JSON structure should look like this:

```json
{
  "packageName": "com.yeasin50.patch_pal",
  "version": "1.0.0",
  "items": [
    {
      "name": "number of mango",
      "value": 3,
      "message": "added 3 mangos"
    },
    {
      "name": "rain",
      "value": true,
      "message": "enabled rain based on weather"
    }
  ],
  "updates": ["looking for updates..."]
}
```

## Usage

Follow these steps to integrate `patch_pal` into your Flutter project:

### Step 1: Add Dependency

Add `patch_pal` as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  patch_pal: ^1.0.0 # Latest version
```

Alternatively, if you want to use the latest from the repository, use:

```yaml
patch_pal:
  git:
    url: https://github.com/yeasin50/patch_pal.git
    ref: master
```

### Step 2: Import the Package

Import the package in your Dart code:

```dart
import 'package:patch_pal/patch_pal.dart';
```

### Step 3: Initialize the Configuration

Initialize the path to your JSON configuration file using `PatchPal.init(yourJsonConfigFilePath);`. You can use a `FutureBuilder` to set up the path asynchronously. The `yourJsonConfigFilePath` should return a valid JSON file.

### Step 4: Access Values

You can access values using the `PatchItemName`. Here are some common use cases:

- To show a dialog, use `PatchPal.dialog`.
- Replace a widget with a patcher view using `PatchPal.view`.
- Show overlays or stack widgets based on value using `PatchPal.overlay`.
- Switch between widgets based on the value using `PatchPal.switcher`.

## TODO List

- [ ] Config (JSON) generator
- [x] Alert widgets and views
- [ ] Stream or ValueListenable support

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

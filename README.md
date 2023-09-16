# PatchPal

[![Flutter CI](https://github.com/yeasin50/patch_pal/actions/workflows/flutter_test.yaml/badge.svg)](https://github.com/yeasin50/patch_pal/actions/workflows/flutter_test.yaml)

`patch_pal` package help to enable/disable feature of app from json file. use raw git [path like this](https://github.com/yeasin50/AssetsFor_/blob/master/apps/patch_pal/test.json)

<!-- ## Features

  -->

## Getting started

The Json structure will be like

```json
{
  "packageName": "com.yeasin50.patch_pal",
  "version": "1.0.0",
  "items": [
    {
      "name": "number of mango",
      "value": 3,
      "message": "added 3 mango"
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

Include short and useful examples for package users. Add longer examples
to [`/example`](/example) folder.

1. add dependency

   ```yaml
   patch_pal:
   git:
     url: https://github.com/yeasin50/patch_pal.git
     ref: master
   ```

2. initialize config path

   ```dart
   /// You need to setup the path, you can use [FutureBuilder]
   PatchPal.setUp(yourJsonConfigFilePath);
   ```

3. Then you can get value using PatchItemName

   ```dart
   PatcherViewOnFalse(patchItemName: 'rain' )
   ```

### TODO

- [ ] Config(Json) generator
- [ ] version based features
- [ ] alert widgets and views
- [ ] stream or ValueLister

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

import '../../patch_pal.dart';

@protected
abstract class PatchRepo {
  const PatchRepo({required this.configLocation, this.httpClient});

  /// The location of the config file{json}.
  final String configLocation;

  final http.Client? httpClient;

  Future<PatchInfo> checkUpdate();

  Future<void> saveVersion(PatchInfo info);
}

import 'package:flutter/foundation.dart';

import '../models/patch_info.dart';
import 'package:http/http.dart' as http;

@protected
abstract class PatchRepo {
  const PatchRepo({required this.configLocation, this.httpClient});

  /// The location of the config file{json}.
  final String configLocation;

  final http.Client? httpClient;

  Future<PatchInfo> checkUpdate();

  Future<void> saveVersion(PatchInfo info);
}

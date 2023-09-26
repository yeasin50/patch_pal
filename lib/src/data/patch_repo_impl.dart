import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:patch_pal/src/domain/models/patch_exception.dart';

import '../domain/models/patch_info.dart';
import '../domain/repository/update_notifier_repo.dart';

/// PatchPalImplement is the implementation of [PatchPal]
/// It is used internally by [PatchPal] to get the patch info from the server.
@protected
class PatchRepoImpl extends PatchRepo {
  const PatchRepoImpl({required super.configLocation, super.httpClient});

  @override
  Future<PatchInfo> checkUpdate() async {
    try {
      final cl = httpClient ?? http.Client();

      final response = await cl.get(Uri.parse(configLocation));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data is! Map<String, dynamic> || data.isEmpty) {
          throw PatchUnsupportedFormat();
        }

        final info = PatchInfo.fromMap(data);
        return info;
      }
      throw PatchNetworkException();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveVersion(PatchInfo info) async {
    throw UnimplementedError();
  }
}
